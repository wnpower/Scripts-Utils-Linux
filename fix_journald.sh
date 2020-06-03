#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

find /var/log/journal/ -delete
systemctl restart systemd-journald
 
 
logrotate -f /etc/logrotate.conf
rm /var/lib/rsyslog/imjournal.state
systemctl restart rsyslog
