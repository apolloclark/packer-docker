# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

Docker.validate_version!

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.get(
      ENV['DOCKER_USERNAME'] + "/" + ENV['PACKAGE'] + ":" + ENV['PACKAGE_VERSION'] + "-" + ENV['IMAGE_NAME']
    )

    # https://github.com/mizzy/specinfra
    # https://docs.docker.com/engine/api/v1.24/#31-containers
    # https://github.com/swipely/docker-api
    # https://serverspec.org/resource_types.html
    set :os, family: :redhat
    set :backend, :docker
    set :docker_image, image.id
  end

  def os_version
    command("cat /etc/system-release").stdout
  end

  def sys_user
    command("whoami").stdout.strip
  end



  it "installs the right version of Centos" do
    expect(os_version).to include("CentOS")
    expect(os_version).to include("7.6.1810")
  end

  it "runs as root" do
    expect(sys_user).to include("root")
  end


  # packages
  describe package("java-11-openjdk") do
    it { should be_installed }
    its('version') { should eq '11.0.2.7-0.el7_6' }
  end

  describe command("java --version") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain '11.0.2' }
  end

end
