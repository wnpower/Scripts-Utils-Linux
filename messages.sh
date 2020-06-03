#!/bin/bash
tail -n 100000 /var/log/messages | grep -v Firewall | grep -v named | grep -v pure | grep -v crond | grep -v snmpd | grep -v repeated | grep -v "nscd:" | grep -vi "sssd" | grep -v "systemd: Started" | grep -v "systemd: Starting" | grep -v "systemd: Removed slice" | grep -v "systemd: Created slice" | grep -v "systemd: Stopping" | grep -v "freedesktop" | grep -v "dhclient"
