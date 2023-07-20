#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

if (grep -i "AlmaLinux release 8" /etc/redhat-release > /dev/null && hostnamectl status | grep "Virtualization: openvz" > /dev/null); then
	dnf remove iptables iptables-services iptables-libs -y
	dnf install http://mirror.centos.org/centos/7/os/x86_64/Packages/iptables-1.4.21-35.el7.x86_64.rpm -y
	dnf -y install yum-plugin-versionlock
	dnf versionlock iptables iptables-services iptables-libs
	rpm -i --nodeps --justdb --noscripts --notriggers https://repo.almalinux.org/almalinux/8/BaseOS/x86_64/os/Packages/nftables-0.9.3-26.el8.x86_64.rpm 
else
	echo "AL8 and OVZ not detected"
	exit 1
fi

exit 0
