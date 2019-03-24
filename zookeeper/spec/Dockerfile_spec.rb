# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

Docker.validate_version!

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.get(
      ENV['DOCKER_USERNAME'] + "/" + ENV['PACKAGE'] + ":" + ENV['PACKAGE_VERSION']
    )
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
end