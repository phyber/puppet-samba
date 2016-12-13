require 'spec_helper'

describe 'samba::server::config', :type => :class do
  context "on a Debian OS" do
    let( :facts ) { { :osfamily => 'Debian' } }

    it { should contain_file('/etc/samba/smb.conf').with_owner('root') }
  end

  context "on a FreeBSD OS" do
    let(:facts) {{ :osfamily => 'FreeBSD' }}
    it {
      should contain_file('/usr/local/etc/smb4.conf')
        .with_owner('root')
        .with_group('wheel')
    }
  end
end

