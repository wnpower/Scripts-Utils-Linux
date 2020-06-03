#!/bin/bash

if [ ! -f /proc/vz/veinfo ]; then
	echo "OpenVZ not detected."
	exit 1
fi

if ! uname -r | grep "^2.6" >/dev/null; then
	echo "Kernel does not seems to be affected"
	exit 1
fi

function changePIDFile()
{

	echo "Processing $1..."
	grep -r "^PIDFile=/var/run/" $1 | uniq | while read LINE
	do
		SERVICE=$(echo "$LINE" | cut -d':' -f1 | rev | cut -d'/' -f1 | rev)
		SERVICE_NOEXT=$(echo $SERVICE | sed 's/\.service//')
		PIDLINE=$(echo "$LINE" | cut -d':' -f2 | sed 's/\/var\/run/\/run/')

		echo "Fixing $SERVICE..."
		mkdir /etc/systemd/system/$SERVICE.d/ 2>/dev/null

cat > "/etc/systemd/system/$SERVICE.d/override.conf" << EOF
[Service]

$PIDLINE
EOF

		systemctl daemon-reload

		if systemctl is-active --quiet $SERVICE; then
			echo "Restarting $SERVICE.."
			if [ -f /scripts/restartsrv_$SERVICE_NOEXT ]; then
				/scripts/restartsrv_$SERVICE_NOEXT	
			else
				systemctl restart $SERVICE
			fi
		fi
	done
}

changePIDFile "/usr/lib/systemd/system/"
echo ""
changePIDFile "/etc/systemd/system/"

