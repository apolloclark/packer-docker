# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

Docker.validate_version!

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.get("apolloclark/metricbeat")

    # https://github.com/mizzy/specinfra
    # https://docs.docker.com/engine/api/v1.24/#31-containers
    # https://github.com/swipely/docker-api
    # https://serverspec.org/resource_types.html
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
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
    expect(package("metricbeat")).to be_installed
  end

  it "don't run as root" do
    expect(sys_user).to eql("metricbeat")
  end


  describe command("metricbeat help") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain 'Usage' }
    its(:stdout) { should contain 'metricbeat' }
  end

  describe command("metricbeat version") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain '6.5.4' }
  end

  describe command("metricbeat setup --help") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain 'This command does initial setup' }
  end

  describe command("metricbeat test config -c /etc/metricbeat/metricbeat.yml") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should eq "Config OK\n" }
    its(:stderr) { should eq '' }
  end

  describe file('/usr/share/metricbeat/bin/metricbeat') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 755 }
  end

  describe file('/etc/metricbeat/metricbeat.yml') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 644 }
  end

  describe file('/etc/metricbeat') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_mode 755 }
  end

  describe file('/usr/share/metricbeat/bin') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_mode 755 }
  end

  describe file('/usr/share/metricbeat/kibana') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_mode 755 }
  end

  describe process("metricbeat") do
    its(:user) { should eq "metricbeat" }
    its(:args) { should contain '-e' }
  end

  # https://serverspec.org/resource_types.html#user
  describe user('metricbeat') do
    it { should exist }
    it { should have_uid 1000 }
    it { should belong_to_group "metricbeat" }
    it { should have_home_directory '/usr/share/metricbeat' }
    it { should have_login_shell '/bin/bash' }
  end

  describe group('metricbeat') do
    it {should exist}
    it { should have_gid 1000}
  end
end