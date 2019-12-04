# Vagrant and Ansible
Create testing environment with Nginx as load balancer, two Tomcat instances as web servers, MySQL instance as database server and Jenkins instance as CI/CD server to deploy [Java application](https://github.com/Pazzl/JavaSampleApp).

As VMware ESXi are using as virtualization environment, **vagrant-vmware-esxi** plugin for Vagrant and VMware **ovftool** have to be installed.

### Install Vagrant
```
$ sudo apt update && sudo apt install vagrant -y
$ wget https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
$ sudo dpkg -i vagrant_2.2.6_x86_64.deb
```
### Install Vagrant VMware ESXi plugin
```
$ vagrant plugin install vagrant-vmware-esxi
$ vagrant plugin install vagrant-reload
```
### Install VMware ovftool
```
$ wget "https://www.dropbox.com/s/zvw9hfqk9ozxhpj/VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle?dl=1" -O "VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle"
$ chmod 755 ./VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle
$ sudo ./VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle
```

As we are using Ansible to provision our environment, first we need to install it.
### Install Ansible
```
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```


So the preparation part is over and now we are ready to start with setting up variables for deploying and provisioning.
* First of all you have to add user to ESXi host and grant it to access via ssh (You can easily Google how to do this)
* Then you have to change IP address for ESXi host at **Vagrantfile**
* In the folder that contains this repo folder you have to create several files:
  * **esxi_vagrant_secret**: Password for user vagrant to access ESXi host via ssh
  * **jenkins_secret**: Password for user jenkins to access Tomcat instance from Jenkins CI/CD to deploy WAR package
  * **db_secret**: Password for user to access the application's database
  * **mysql_root_secret**: Password for root user to set up

Now we are ready to create and provision all environment. Change folder to have **Vagrantfile** in it. Then you have to
```
$ vagrant up
```
After all is done you have to first configure Jenkins.
Please look the contents of the file **initialAdminPassword**
```
$ cat ../initialAdminPassword
```
You can see initial password to unlock your Jenkins installation.

So, unlock it and Install sudgested plugins. After installation complete please create your first admin user. Then verify that Jenkins URL is valid.
