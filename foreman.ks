# Bare bones kickstart template for centos 7 

#graphical
text

eula --agreed
firstboot --enable 

url --url http://10.10.10.118/centos7_repo

%packages
@^minimal
@core
chrony
kexec-tools
python3

%end

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --hostname=localhost.localdomain
network --bootproto=dhcp --device=ens3 --onboot=on

# Run the Setup Agent on first boot
firstboot --enable

ignoredisk --only-use=sda
clearpart --all
zerombr
partition / --size=20000 --ondrive=/dev/sda --grow --fstype=ext4

# System timezone
timezone America/Chicago --isUtc

# Root password
rootpw --iscrypted $6$CPrYkBxB6w2w2SuK$bXuVMVosixstCRpZ7cOmOukwaA3df7TdacCL.CAL.J.imQEDV.aJudFdoZGCysgLvnKmk7EJl3LDHg7V5Vevn.

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end

%post
sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
# yum install via http is broken...
yum -y install https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
yum -y install https://yum.theforeman.org/releases/1.24/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer
foreman-installer

%end
