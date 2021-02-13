
lang en_US
langsupport en_US
keyboard us
timezone America/Chicago
# root password is initially set to "password"
rootpw --iscrypted $1$ctsMJh4F$oAValhAnuEr8/CveubFmo1
user --disabled
reboot
text
install
url --url http://us.archive.ubuntu.com/ubuntu/ 

# overwrite partitioning without confirmation
preseed partman-partitioning/confirm_write_new_label boolean true
preseed partman/choose_partition select finish
preseed partman/confirm boolean true
preseed partman/confirm_nooverwrite boolean true
preseed partman-basicmethods/method_only boolean false

bootloader --location=mbr 
zerombr yes
clearpart --all --initlabel 
part / --fstype ext4 --size 1 --grow --asprimary --ondisk sda 
auth  --useshadow  --enablemd5 
network --bootproto=dhcp 
firewall --disabled 
skipx

%packages
@ openssh-server
software-properties-common
open-vm-tools

%post
apt update -y
apt upgrade -y

sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config

systemctl disable ufw

apt-add-repository --yes --update ppa:ansible/ansible
apt install -y  ansible 

cat << EOF > /etc/sysctl.d/30-disable-ipv6.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.all.autoconf = 0
net.ipv6.conf.default.autoconf = 0
net.ipv6.conf.lo.autoconf = 0
EOF
