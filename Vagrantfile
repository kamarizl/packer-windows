# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "windows7"
  config.vm.box_url = "box/windows7.box"
  # config.vm.hostname = "windows7"

  config.vm.network :forwarded_port, guest: 3389, host_ip: "127.0.0.1", host: 33389, id: "rdp", auto_correct:true
  config.vm.network :forwarded_port, guest: 5985, host_ip: "127.0.0.1", host: 55985, id: "winrm", auto_correct:true

  # add another network interface :)
  # config.vm.network "public_network", bridge: "Realtek PCIe GBE Family Controller", auto_config: false
  # config.vm.network "private_network", ip: "192.168.33.

  config.vm.provision "shell",
    path: "scripts/chocolatey.ps1"

  config.vm.provision "shell",
    path: "scripts/guest-addition.bat"

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    vb.name = "windows7"
    vb.memory = "2048"
    vb.cpus = 2
  end

end