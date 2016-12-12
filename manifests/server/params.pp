# == Class samba::server::params
#
class samba::server::params {
  case $::osfamily {
    'Redhat': {
      $service_name  = 'smb'
      $package_name  = 'samba'
      $config_file   = '/etc/samba/smb.conf'
      $script_prefix = '/sbin'
      $pdbedit       = '/usr/bin/pdbedit'
    }
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          case $::operatingsystemmajrelease {
            '8' : {
              $service_name  = 'smbd'
              $package_name  = 'samba'
              $config_file   = '/etc/samba/smb.conf'
              $script_prefix = '/sbin'
              $pdbedit       = '/usr/bin/pdbedit'
            }
            default: {
              $service_name  = 'samba'
              $package_name  = 'samba'
              $config_file   = '/etc/samba/smb.conf'
              $script_prefix = '/sbin'
              $pdbedit       = '/usr/bin/pdbedit'
            }
          }
        }
        'Ubuntu': {
          $service_name  = 'smbd'
          $package_name  = 'samba'
          $config_file   = '/etc/samba/smb.conf'
          $script_prefix = '/sbin'
          $pdbedit       = '/usr/bin/pdbedit'
          $nmbd_name     = 'nmbd'
        }
        default: {
          $service_name  = 'samba'
          $package_name  = 'samba'
          $config_file   = '/etc/samba/smb.conf'
          $script_prefix = '/sbin'
          $pdbedit       = '/usr/bin/pdbedit'
        }
      }
    }
    'Gentoo': {
      $service_name  = 'samba'
      $package_name  = 'samba'
      $config_file   = '/etc/samba/smb.conf'
      $script_prefix = '/sbin'
      $pdbedit       = '/usr/bin/pdbedit'
    }
    'Archlinux': {
      $service_name  = 'smbd'
      $package_name  = 'samba'
      $config_file   = '/etc/samba/smb.conf'
      $script_prefix = '/sbin'
      $pdbedit       = '/usr/bin/pdbedit'
      $nmbd_name     = 'nmbd'
    }

    # Currently Gentoo has $::osfamily = "Linux". This should change in
    # Factor 1.7.0 <http://projects.puppetlabs.com/issues/17029>, so
    # adding workaround.
    'Linux': {
      case $::operatingsystem {
        'Gentoo':  {
          $service_name  = 'samba'
          $package_name  = 'samba'
          $config_file   = '/etc/samba/smb.conf'
          $script_prefix = '/sbin'
          $pdbedit       = '/usr/bin/pdbedit'
        }
        default: { fail("${::operatingsystem} is not supported by this module.") }
      }
    }
    'FreeBSD': {
        $service_name  = 'samba_server'
        $package_name  = 'net/samba44'
        $config_file   = '/usr/local/etc/smb4.conf'
        $script_prefix = '/usr/local/sbin'
        $pdbedit       = '/usr/local/bin/pdbedit'
    }
    default: { fail("${::osfamily} is not supported by this module.") }
  }
}
