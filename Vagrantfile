# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://www.vagrantup.com/docs/provisioning/salt.html
# with box name fix

Vagrant.configure("2") do |config|

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
				"ubuntu"	=> "salt/keys/ubuntu.pub",
				"windows10"	=> "salt/keys/windows10.pub",
			}

		end
	end

	config.vm.define "ubuntu", autostart: false do |ubuntu|
		## Choose your base box
		ubuntu.vm.box		= "hashicorp/bionic64"
		ubuntu.vm.hostname	= "ubuntu"

		## Deactivate vagrant-vbguest plugin function to
		# update guest utils in image
		ubuntu.vbguest.auto_update	= false

		ubuntu.vm.network "private_network", ip: "192.168.2.12", virtualbox__intnet: true

		## Use all the defaults:
		ubuntu.vm.provision :salt do |ubuntu|
			ubuntu.install_master	= true
			ubuntu.no_minion	= false
			ubuntu.install_type	= "stable"
			ubuntu.verbose		= true
			ubuntu.colorize		= true
			ubuntu.run_highstate	= false

			ubuntu.minion_config	= "salt/minion_ubuntu"
			ubuntu.minion_id	= "ubuntu"

			ubuntu.minion_key	= "salt/keys/ubuntu.pem"
			ubuntu.minion_pub	= "salt/keys/ubuntu.pub"
		end

		#config.vm.network :forwarded_port, id: 'ssh', guest: 22, host: 2222, disabled: true
		#config.ssh.guest_port = 2222
	end


	# https://docs.saltstack.com/en/latest/topics/cloud/windows.html
	# ggf. https://codeblog.dotsandbrackets.com/vagrant-windows/
	# ggf. https://gist.github.com/tknerr/7fc4a4191903e3611c45
	#          https://github.com/WinRb/WinRM#troubleshooting
	# https://dev.to/jeikabu/reusable-windows-vms-with-vagrant-2h5c
	#
	# https://www.vagrantup.com/docs/boxes/base.html
	#
	# https://github.com/UtahDave/salt-vagrant-demo/blob/master/Vagrantfile
	#
	# https://app.vagrantup.com/StefanScherer/boxes/windows_10
	# https://github.com/StefanScherer/packer-windows
	#
	# https://gist.github.com/santrancisco/a7183470efa0e3412222670d0bfb3da5
	#
	# https://softwaretester.info/create-windows-10-vagrant-base-box/
	#
	# ( https://github.com/hashicorp/vagrant/issues/9719 )
	#
	# ( https://github.com/saldl/saldl/releases )
	# ( https://www.metaltoad.com/blog/git-push-all-branches-new-remote )
	#
	# interesting but linux based only and using 2015.x
	# ( https://github.com/arnisoph/saltbox-vagrant )
	#
	# https://docs.saltstack.com/en/latest/topics/tutorials/walkthrough_macosx.html
	#
	config.vm.define "windows", autostart: false do |windows|
		## Choose your base box
		windows.vm.box		= "StefanScherer/windows_10"
		windows.vm.hostname	= "windows10"

		## Deactivate vagrant-vbguest plugin function to
		# update guest utils in image
		windows.vbguest.auto_update	= false

		windows.vm.network "private_network", ip: "192.168.2.13", virtualbox__intnet: true
		# https://github.com/hashicorp/vagrant/issues/2779#issuecomment-545167045
		#windows.vm.provider 'virtualbox' do |vb|
		#	# This is the important part. You could also add extras
		#	# like '--nictype1', 'virtio'.
		#	vb.customize ['modifyvm', :id, '--nic1', 'natnetwork', '--nat-network1', 'MyNatNetwork']
		#end

		## For masterless, mount your salt file root
		#windows.vm.synced_folder "salt/roots/", "c:\\salt\\srv\\salt"

		## Use all the defaults:
		windows.vm.provision :salt do |salt|
			salt.minion_config	= "salt/minion_windows"
			salt.run_highstate	= false

			salt.minion_id		= "windows10"
			salt.minion_key		= "salt/keys/windows10.pem"
			salt.minion_pub		= "salt/keys/windows10.pub"
		end
	end

end
