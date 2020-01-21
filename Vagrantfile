# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://www.vagrantup.com/docs/provisioning/salt.html
# with box name fix

Vagrant.configure("2") do |config|

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

	config.vm.define "salt", primary: true do |salt|
		## Choose your base box
		salt.vm.box		= "hashicorp/bionic64"
		salt.vm.hostname	= "salt"

		## Deactivate vagrant-vbguest plugin function to
		# update guest utils in image
		salt.vbguest.auto_update	= false

		salt.vm.network "private_network", ip: "192.168.2.11", virtualbox__intnet: true
		# https://github.com/hashicorp/vagrant/issues/2779#issuecomment-545167045
		#salt.vm.provider 'virtualbox' do |vb|
		#	# This is the important part. You could also add extras
		#	# like '--nictype1', 'virtio'.
		#	vb.customize ['modifyvm', :id, '--nic1', 'natnetwork', '--nat-network1', 'NatNetwork']
		#end
		#config.vm.network :forwarded_port, id: 'ssh', guest: 22, host: 2221, disabled: true
		#config.ssh.guest_port = 2221


		## For masterless, mount your salt file root
		salt.vm.synced_folder "salt/roots/", "/srv/salt/"

		## Use all the defaults:
		salt.vm.provision :salt do |salt|
			salt.install_master	= true
			salt.no_minion		= false
			salt.install_type	= "stable"
			salt.verbose		= true
			salt.colorize		= true
			salt.run_highstate	= false

			#salt.master_config	= "salt/master"
			salt.minion_config	= "salt/minion_salt"
			salt.minion_id		= "salt"

			salt.master_key		= "salt/keys/salt.pem"
			salt.master_pub		= "salt/keys/salt.pub"
			salt.minion_key		= "salt/keys/salt.pem"
			salt.minion_pub		= "salt/keys/salt.pub"
			salt.seed_master	= {
				"salt"		=> "salt/keys/salt.pub",
			}

		end
	end
end
