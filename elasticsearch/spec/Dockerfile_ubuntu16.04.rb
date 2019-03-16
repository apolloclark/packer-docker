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
    # https://github.com/elastic/elasticsearch-docker/tree/master/tests
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  def os_version
    command("uname -a").stdout
  end

  def sys_user
    command("whoami").stdout.chomp
  end



  it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu")
  end

  it "installs required packages" do
    expect(package("elasticsearch")).to be_installed
  end

  it "runs as as non-root" do
    expect(sys_user).to eql("elasticsearch")
  end

  describe command("elasticsearch --version") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain ENV['PACKAGE_VERSION'] }
  end

  describe command("elasticsearch --help") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain 'Option' }
    its(:stdout) { should contain 'elasticsearch' }
  end

  describe file('/usr/share/elasticsearch') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'elasticsearch' }
    it { should be_grouped_into 'root' }
    it { should be_mode 775 }
  end

  describe file('/usr/share/elasticsearch/bin/elasticsearch') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'elasticsearch' }
    it { should be_grouped_into 'root' }
    it { should be_mode 775 }
  end

  describe file('/usr/share/elasticsearch/config/elasticsearch.yml') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'elasticsearch' }
    it { should be_grouped_into 'root' }
    it { should be_mode 775 }
  end

  describe file('/usr/share/elasticsearch/bin') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'elasticsearch' }
    it { should be_grouped_into 'root' }
    it { should be_mode 775 }
  end

  # https://serverspec.org/resource_types.html#user
  describe user('elasticsearch') do
    it { should exist }
    it { should have_uid 1000 }
    it { should belong_to_group "elasticsearch" }
    it { should have_home_directory '/usr/share/elasticsearch' }
    it { should have_login_shell '/bin/bash' }
  end

  describe group('elasticsearch') do
    it {should exist}
    it { should have_gid 1000}
  end
end