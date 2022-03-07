#!/bin/bash
echo "Parando EXIM..."
service exim stop
sleep 10
killall -9 exim eximd
sleep 5
echo "Renombrando ejecutable de exim para que no levante solo..."
mv /usr/sbin/exim /usr/sbin/exim.bak

echo "Limpiando correos..."
find /var/spool/exim -mindepth 2 -type f -delete

echo "Borrando DB Exim..."
find /var/spool/exim/db -type f -delete

echo "Limpiando eximstats..."
echo "truncate table sends;" | sudo -H -u root mysql eximstats
echo "truncate table defers;" | sudo -H -u root mysql eximstats
echo "truncate table failures;" | sudo -H -u root mysql eximstats
echo "truncate table smtp;" | sudo -H -u root mysql eximstats

echo "Renombrando ejecutable de exim..."
mv /usr/sbin/exim.bak /usr/sbin/exim
service exim restart

echo "Listo!"
