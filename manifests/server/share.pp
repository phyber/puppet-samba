define samba::server::share($ensure = present,
                    $comment = '',
                    $path = '',
                    $browsable = '',
                    $copy = '',
                    $create_mask = '',
                    $directory_mask = '',
                    $guest_ok = '',
                    $read_only = '') {

  $context = "/files/etc/samba/smb.conf"
  $target = "target[. = '${name}']"

  augeas { "${name}-section":
    context => $context,
    changes => $ensure ? {
      present => "set ${target} '${name}'",
      default => "rm ${target} '${name}'",
    },
    require => Class["samba::server::config"],
    notify => Class["samba::server::service"]
  }

  if $ensure == "present" {
    augeas { "${name}-comment":
      context => $context,
      changes => $comment ? {
        default => "set ${target}/comment '${comment}'",
        '' => "rm ${target}/comment",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-path":
      context => $context,
      changes => $path ? {
        default => "set ${target}/path '${path}'",
        '' => "rm ${target}/path",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-browsable":
      context => $context,
      changes => $browsable ? {
        true => "set ${target}/browsable yes",
        false => "set ${target}/browsable no",
        default => "rm ${target}/browsable",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-copy":
      context => $context,
      changes => $copy ? {
        default => "set ${target}/copy '${copy}'",
        '' => "rm ${target}/copy",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-create_mask":
      context => $context,
      changes => $create_mask ? {
        default => "set \"${target}/create mask\" yes",
        '' => "rm \"${target}/create mask\"",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-directory_mask":
      context => $context,
      changes => $directory_mask ? {
        default => "set \"${target}/directory mask\" '${directory_mask}'",
        '' => "rm \"${target}/directory mask\"",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-guest_ok":
      context => $context,
      changes => $guest_ok ? {
        true => "set \"${target}/guest ok\" yes",
        false => "set \"${target}/guest ok\" no",
        default => "rm \"${target}/guest ok\"",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-read_only":
      context => $context,
      changes => $read_only ? {
        true => "set \"${target}/read only\" yes",
        false => "set \"${target}/read only\" no",
        default => "rm \"${target}/read_only\"",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }
  }
}
