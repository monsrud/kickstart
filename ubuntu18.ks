#platform=AMD64 or Intel EM64T

lang en_US
langsupport en_US
keyboard us
timezone America/Chicago
rootpw --iscrypted $1$ctsMJh4F$oAValhAnuEr8/CveubFmo1
user --disabled
reboot
text
install
url --url http://10.10.10.118/ubuntu18
bootloader --location=mbr 
zerombr yes
clearpart --all --initlabel 
part / --fstype ext4 --size 1 --grow --asprimary --ondisk sda 
auth  --useshadow  --enablemd5 
network --bootproto=dhcp --device=eth0
firewall --disabled 
skipx

%packages
openssh-server
