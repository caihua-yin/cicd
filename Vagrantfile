# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.synced_folder "/Users/yincaihua/vagrant", "/vagrant"

  # Development
  config.vm.define "dev" do |d|
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "dev"
    d.vm.network "private_network", ip: "192.168.33.20"
    d.vm.provision :shell, path: "provision/dev.sh"
    d.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 4
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end

  # Production
  (1..3).each do |i|
    config.vm.define "prod0#{i}" do |d|
      d.vm.box = "ubuntu/trusty64"
      d.vm.hostname = "prod0#{i}"
      d.vm.network "private_network", ip: "192.168.33.2#{i}"
      d.vm.provider "virtualbox" do |v|
        if i == 2
            v.memory = 2048 # Elasticsearch need reserve 1GB heap size to start, so use 2.5GB memory
        else
            v.memory = 2048
        end
      end
    end
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_install = true
    config.vbguest.no_remote = true
  end
end
