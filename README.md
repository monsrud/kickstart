# Kickstart Examples

These are some example kickstart files for RHEL/Centos and Ubuntu.

To create a repo for RHEL/Centos, just copy the install DVD to and put it in rhel_repo or centos_repo in the document root of your web server.  
Edit the url in the kickstart file to point to the dirctory you've created. Note that the boot parameter is **inst.ks=...**

![Kickstart Via RHEL/Centos Boot Prompt](images/centos_kickstart.png?raw=true "Kickstart Via RHEL/Centos Boot Prompt")

To create a repo for Ubuntu, you need to use the apt-mirror command to make a mirror of the ubuntu repo. You can do this on Centos or Ubuntu. But,
it is easier to do on Ubuntu.  Create the mirror in the document root of your web server. In order to kickstart Ubuntu, you need to download 
the Ubuntu netboot installer and boot using it.   At the install dialog, press ESC and then TAB and edit the boot line. Note that the boot parameter is **ks=...**


![Kickstart Via Ubuntu Boot Prompt](images/ubuntu_kickstart.png?raw=true "Kickstart Via Ubuntu Boot Prompt")
