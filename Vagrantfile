# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://www.vagrantup.com/docs/provisioning/salt.html
# with box name fix

Vagrant.configure("2") do |config|
	## Choose your base box
	config.vm.box = "hashicorp/bionic64"

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
