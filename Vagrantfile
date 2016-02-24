# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8080,    host: 8080
  config.vm.network "forwarded_port", guest: 3306,  host: 3306

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.35.25", auto_config: false

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  # config.vm.synced_folder('----localfolder-----', '/home/vagrant/code', :nfs => true)
  # config.vm.synced_folder '.', '/home/vagrant/code', nfs: true
  config.vm.synced_folder './www', '/var/www', nfs: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #

  config.vm.provider "virtualbox" do |v|
    # Don't boot with headless mode
    v.gui = false

    # Use VBoxManage to customize the VM. For example to change memory:
    v.customize ["modifyvm", :id, "--memory",               "512"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap",      "95"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1",  "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1",         "on"]
    ### Change network card to PCnet-FAST III
    # For NAT adapter
    v.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
    # For host-only adapter
    v.customize ["modifyvm", :id, "--nictype2", "Am79C973"]
  end

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # install some base packages
  config.vm.provision :shell, path: "provision.sh"
end
