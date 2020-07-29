# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "hashicorp/bionic64"
	config.vm.box_version = "1.0.282"
	config.vm.hostname = "master1"
        config.vm.network "forwarded_port", guest: 32768, host: 32768
        config.vm.network "forwarded_port", guest: 32769, host: 32769
        config.vm.network "forwarded_port", guest: 8000, host: 8000
	config.vm.provider "virtualbox" do |v|
		v.name = "vm-master"
                v.memory = 2048
                v.cpus = 2
	end
	config.vm.provision :shell, path: "0-vagrant-bootstrap.sh"
end
