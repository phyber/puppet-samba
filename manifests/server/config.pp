# == Class samba::server::config
#
class samba::server::config (
) inherits ::samba::server::params {
  # FreeBSD places the samba configuration in /usr/local/etc, so this directory
  # isn't needed there.
  unless $::osfamily == 'FreeBSD' {
    file { '/etc/samba':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      before => File[$::samba::server::params::config_file],
    }
  }

  file { $::samba::server::params::config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Class['samba::server::install'],
    notify  => Class['samba::server::service'],
  }
}
