# -*- mode: ruby -*-
# vi: set ft=ruby :

nodes = [
  { hostname: 'srv-v-nginx', box: 'generic/ubuntu1804', mac: '00:50:56:AA:AA:00' },
  { hostname: 'srv-v-tomcat1', box: 'generic/ubuntu1804', mac: '00:50:56:AA:AA:01' },
  { hostname: 'srv-v-tomcat2', box: 'generic/ubuntu1804', mac: '00:50:56:AA:AA:02' },
  { hostname: 'srv-v-jenkins', box: 'generic/ubuntu1804', mac: '00:50:56:AA:AA:03' },
  { hostname: 'srv-v-mysql', box: 'generic/ubuntu1804', mac: '00:50:56:AA:AA:04' }
]

Vagrant.configure("2") do |config|

  nodes.each do |node|

    config.vm.define node[:hostname] do |node_config|
      node_config.vm.hostname = node[:hostname]
      node_config.vm.box = node[:box]

      node_config.vm.provider :vmware_esxi do |esxi|
	esxi.esxi_hostname = '46.4.53.205'
	esxi.esxi_username = 'vagrant'
	esxi.esxi_password = 'file:../esxi_vagrant_secret'
	esxi.esxi_virtual_network = ['local']
	esxi.esxi_disk_store = 'datastore1'
	esxi.guest_name = node[:hostname]
	esxi.guest_mac_address = [node[:mac]]
	esxi.guest_username = 'vagrant'
	esxi.guest_memsize = '2048'
	esxi.guest_numvcpus = '1'
	esxi.guest_nic_type = 'e1000e'
	esxi.guest_disk_type = 'thin'
	esxi.guest_guestos = 'ubuntu-64'
	esxi.local_allow_overwrite = 'True'
	esxi.local_failonwarning = 'True'
      end

      node_config.vm.provision 'ansible' do |ansible|
	ansible.playbook = 'provision/playbook.yml'
	ansible.groups = {
	  'proxy' => ['srv-v-nginx'],
	  'tomcat' => ['srv-v-tomcat[1:2]'],
	  'db' => ['srv-v-mysql'],
	  'cicd' => ['srv-v-jenkins']
	}
	ansible.verbose = true
      end

    end
  end

end
