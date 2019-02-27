# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

Docker.validate_version!

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.get("apolloclark/tomcat:latest")

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

  def tomcat_version
    command("cd /usr/local/tomcat/lib && java -cp catalina.jar org.apache.catalina.util.ServerInfo").stdout
  end



  it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu")
  end

  it "installs tomcat version" do
    expect(tomcat_version).to include("9.0.14.0")
  end

  it "runs as tomcat user" do
    expect(sys_user).to eql("tomcat")
  end

  describe user('tomcat') do
    it { should exist }
    it { should have_uid 1000 }
    it { should belong_to_group "tomcat" }
    it { should have_login_shell '/bin/bash' }
  end

  describe group('tomcat') do
    it {should exist}
    it { should have_gid 1000}
  end

  describe file('/usr/local/tomcat') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'tomcat' }
    it { should be_mode 755 }
  end

  describe file('/usr/local/tomcat/bin') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'tomcat' }
    it { should be_mode 750 }
  end

  describe file('/usr/local/tomcat/conf') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'tomcat' }
    it { should be_mode 750 }
  end

  describe file('/usr/local/tomcat/webapps') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'tomcat' }
    it { should be_mode 750 }
  end
end
