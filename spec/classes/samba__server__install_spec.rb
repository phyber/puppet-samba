require 'spec_helper'

describe 'samba::server::install', :type => :class do
  context "on a Debian OS" do
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should contain_package('samba') }
  end

  context "on a FreeBSD OS" do
    let(:facts) {{ :osfamily => 'FreeBSD' }}
    it { should contain_package('net/samba44') }
  end
end

