# Bare bones kickstart template for Centos 8

text

url --url http://10.10.10.118/centos8_repo/BaseOS

%packages
@^minimal-environment

%end

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --hostname=localhost.localdomain

# Use CDROM installation media
#cdrom

# Run the Setup Agent on first boot
firstboot --enable

ignoredisk --only-use=sda
clearpart --all
zerombr
partition / --size=20000 --ondrive=/dev/sda --grow --fstype=ext4

# System timezone
timezone America/Chicago --isUtc

# Root password is intially set to "password"
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
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
yum update -y
yum upgrade -y
yum install -y epel-release
systemctl disable firealld
%end

