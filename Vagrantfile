# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lubuntu.box"
  config.vm.box_url = "file://./lubuntu.box"
  # config.vm.hostname = "vagrant.example.com"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
    # Enable NFS for Virtualbox
    #config.cache.enable_nfs = true
  end
  unless Vagrant.has_plugin?("vagrant-hosts")
    raise LoadError, "vagrant-hosts plugin is not installed"
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #config.vm.network :forwarded_port, guest: 8161, host: 8161



  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # If you are developing on Windows as well as VM might want to share your
  # .m2 and code repo folders to save space
  # config.vm.synced_folder "D://path/to/code", "/media/code"
  # config.vm.synced_folder "D://path/to/.m2", "/home/ubuntu/.m2"


  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    vb.gui = true
    vb.cpus = 2
    vb.memory = 8192
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    vb.customize ["modifyvm", :id, "--vram", "80"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    vb.customize ["modifyvm", :id, "--uart1", "0x3f8", "4"]
    vb.customize ["storageattach", :id, "--storagectl", "SATAController", "--port", "0", "--nonrotational", "on", "--discard", "on"]
  end

  config.vm.provision "tty",       type: "shell", path: "helpers/00-tty.sh"
  config.vm.provision "apt-setup", type: "shell", path: 'helpers/01-apt-setup.sh'
  config.vm.provision "apt-upgrade", type: "shell", path: 'helpers/02-apt-upgrade.sh'
end
