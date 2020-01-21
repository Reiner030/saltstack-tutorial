# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://www.vagrantup.com/docs/provisioning/salt.html
# with box name fix

Vagrant.configure("2") do |config|
	## Choose your base box
	config.vm.box = "hashicorp/bionic64"

	# To get correct started within Hyper-V 'vagrant up'
	# should be run in PowerShell in Administrative Mode

	# https://www.vagrantup.com/docs/hyperv/limitations.html
	# We need to select "Default Network" when vagrant asks for it.

	# To avoid running 'vagrant up --provider=hyperv' we set
	# here virtualization order (with empty definition block):
	config.vm.provider "hyperv"
	config.vm.provider "virtualbox"

	# which could be enhanced like:
	# https://www.vagrantup.com/docs/hyperv/configuration.html
	#config.vm.provider "hyper-v" do |hyperv|
	#	#hyperv.vmname = "test"
	#	hyperv.cpus = 1
	#	hyperv.memory = 128
	#	# allow nested virtualization
	#	hyperv.enable_virtualization_extensions = true
	#end

	## Deactivate vagrant-vbguest plugin function to
	# update guest utils in image
	config.vbguest.auto_update = false

	## For masterless, mount your salt file root
	config.vm.synced_folder "salt/roots/", "/srv/salt/"

	## Use all the defaults:
	config.vm.provision :salt do |salt|

	salt.masterless = true
	salt.minion_config = "salt/minion"
	salt.run_highstate = true

	end
end
