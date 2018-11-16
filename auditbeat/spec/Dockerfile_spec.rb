# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.get("apolloclark/auditbeat:20181113")

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu")
  end

  # This test is new
  it "installs required packages" do
    expect(package("auditbeat")).to be_installed
  end

  def os_version
    command("uname -a").stdout
  end
end