# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

Docker.validate_version!

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.get("apolloclark/packetbeat:latest")

    # https://github.com/mizzy/specinfra
    # https://docs.docker.com/engine/api/v1.24/#31-containers
    # https://github.com/swipely/docker-api
    # https://serverspec.org/resource_types.html
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
    set :docker_container_create_options, {
      'CapAdd'  => ["net_raw", "net_admin"]
    }
  end

  def os_version
    command("uname -a").stdout
  end

  def sys_user
    command("whoami").stdout.strip
  end



  it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu")
  end

  it "installs required packages" do
    expect(package("oracle-java11-installer")).to be_installed
  end

  describe command("packetbeat version") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain '6.4.2' }
  end

  describe command("java -version") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain 'Usage' }
    its(:stdout) { should contain 'packetbeat' }
  end

  describe process("packetbeat") do
    its(:user) { should eq "packetbeat" }
    its(:args) { should contain '-e' }
  end

  # https://serverspec.org/resource_types.html#user
  describe user('packetbeat') do
    it { should exist }
    it { should have_uid 1000 }
    it { should belong_to_group "packetbeat" }
    it { should have_home_directory '/usr/share/packetbeat' }
    it { should have_login_shell '/bin/bash' }
  end

  describe group('packetbeat') do
    it {should exist}
    it { should have_gid 1000}
  end
end