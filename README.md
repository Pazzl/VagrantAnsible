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

To deploy **WAR** packages form Jenkins to Tomcat we need to install several plugins. Go to **Manage Jenkins**->**Manage plugins**. Select the **Available** tab, locate the **Deploy to container** plugin and install it.

Now you are ready to create a first job.
Click on **New Item**, enter an item name, select **Freestyle project** and click **Ok**

At **General** tab select **GitHub project** and enter GitHub URL of the project.

At **Source Code Management** tab select **Git** options and enter **Repository URL**.

At **Build Triggers** tab select **GitHub hook trigger for GITScm polling**

At **Build Environment** tab select **Delete workspace before build starts** and **Add timestamps to the Console Output**

At **Build** tab click on **Add Build Step** and select **Invoke top-level Maven targets**. In **Goals** enter ```clean compile package```

At **Post-build Actions** tab click on **Add post-build action** and select **Archive the atifacts**. At **Files to archive** enter ```**/*.war```

Then click again on **Add post-build action** and select **Deploy war/ear to a container**. At **WAR/EAR files** enter ```**/*.war```, at **Context path** enter ```/```. Then click on **Add Container*** and select **Tomcat 9.x Remote**. At **Tomcat URL** enter URL of first Tomcat server with tomcat port (for example ```http://192.168.200.12:8080```). Then at **Credentials** click **Add** and select **Jenkins**. In the new window called **Jenkins Credentials Provider: Jenkins** enter **Username** ```jenkins``` and **Password** the you write in preparation step to file **jenkins_secret**. Click **Add** and then select it from drop-down list.

The same way you have to add another container to deploy WAR to second tomcat instance. Credentials are the same at both Tomcat instances, so you have no need to add it again.

Click **Save** to cmplete you Build job.

Now you can manually run the job by clicking **Build Now**
