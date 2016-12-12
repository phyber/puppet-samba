# == Class samba::server::user
#
define samba::server::user (
  $password,
  $user_name = $name,
) {
  require ::samba::server::install
  include ::samba::server::params

  $pdbedit = $::samba::server::params::pdbedit

  exec { "add smb account for ${user_name}":
    command => "/bin/echo -e '${password}\\n${password}\\n' | ${pdbedit} --password-from-stdin -a '${user_name}'",
    unless  => "${pdbedit} '${user_name}'",
    require => User[$user_name],
    notify  => Class['samba::server::service'] #TODO: Is this really required??
  }
}
