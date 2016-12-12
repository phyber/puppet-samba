# == Class samba::server::config
#
class samba::server::config (
) inherits ::samba::server::params {
  file { '/etc/samba':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { $::samba::server::params::config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [File['/etc/samba'], Class['samba::server::install']],
    notify  => Class['samba::server::service']
  }
}
