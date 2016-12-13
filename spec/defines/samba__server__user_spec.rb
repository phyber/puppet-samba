require 'spec_helper'

describe 'samba::server::user', :type => :define do
  let(:title) { 'test_user' }
  let(:params) {{ :password => 'secret' }}
  let(:facts) {{ :osfamily => 'Debian' }}
  let(:pre_condition) { 'include ::samba::server::params' }

  it { is_expected.to contain_samba__server__user('test_user') }
  it { is_expected.to contain_exec('add smb account for test_user').with(
    :command => '/bin/echo -e \'secret\nsecret\n\' | /usr/bin/pdbedit --password-from-stdin -a \'test_user\'',
    :unless  => '/usr/bin/pdbedit \'test_user\'',
    :require => 'User[test_user]',
    :notify  => 'Class[Samba::Server::Service]'
  ) }
end
