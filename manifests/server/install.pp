# == Class samba::server::install
#
class samba::server::install (
) inherits ::samba::server::params {
  package { $::samba::server::params::package_name:
    ensure => installed,
  }
}
