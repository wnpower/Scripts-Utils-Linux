#!/bin/bash
DIA=$(date +"%Y-%m-%d")
LOG="/var/log/exim_mainlog"
if [ $# -eq 0 ]; then
        echo "No se encontraron parámetros pasados al script. Se usarán los logs del día de hoy."
        echo "Si desea utilizar días anteriores, tiene el siguiente modificador: "
        echo ""
        echo "$0 x (donde x es la cantidad de días atrás)"
        echo "-----------------------------------------------------------"
elif [[ $1 =~ ^-?[0-9]+$ ]]; then
        DIA=$(date --date="$1 days ago" +"%Y-%m-%d")
        LOG="/var/log/exim_mainlog*"
else
        echo "$1 no es numérico. No se utilizará este modificador."
fi

IFS=$'\n'
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

echo "";
echo "";
echo -e "${YELLOW}${UNDERLINE}TOP correos enviados o recibidos por ASUNTO --en el día $DIA--${NONE}";
echo "";
echo "";

for OUTPUT in $(grep $DIA $LOG | awk -F"T=\"" '/<=/ {print $2}' | cut -d\" -f1 | sort | uniq -c | sort -nr | head)
do
        echo "";
        echo -e ${RED}$OUTPUT${NONE}
        OUTPUTB=$(echo $OUTPUT | cut -c 9- | sed -e 's:\\:\\\\:g')


        if [ -z "$OUTPUTB" ]
                then
                        OUTPUTB='T\=\"\"'
        fi

        grep $DIA $LOG | grep $OUTPUTB | awk '{print $5}' | sort | uniq -c | sort -nr | head
        echo "";
        echo "";
done

echo "";
echo "";
echo -e "${YELLOW}${UNDERLINE}TOP destinatarios de rebotes (Mail delivery failed: returning message to sender)${NONE}";
echo "";
echo "";
grep $DIA $LOG | grep "Mail delivery failed: returning message to sender" | awk '{print $18}' | sort | uniq -c | sort -nr | head

echo "";
echo "";
echo -e "${YELLOW}${UNDERLINE}TOP cuentas que reciben mails${NONE}";
echo "";
echo "";
grep $DIA $LOG | grep "<=" | awk -F " for " '{print $2}' | sort | uniq -c | sort -nr | head

echo "";
echo "";
echo -e "${YELLOW}${UNDERLINE}TOP logins dovecot${NONE}";
echo "";
echo "";
grep $DIA $LOG | grep "dovecot_login" | awk -F"A=dovecot_login:" '/<=/ {print $2}' | awk '{print $1}' | sort | uniq -c | sort -nr | head -n 10

echo "";
echo "";
echo -e "${YELLOW}${UNDERLINE}TOP usuarios linux que mandaron mails${NONE}";
echo "";
echo "";
grep $DIA $LOG | grep "U=" | awk -F"U=" '/<=/ {print $2}' | awk '{print $1}' | sort | uniq -c | sort -nr | head -8

echo "";
echo "";

echo -e "${YELLOW}${UNDERLINE}TOP cuentas que mandaron mail desde PHP${NONE}";
echo "";
echo "";
grep $DIA $LOG | grep "cwd=" | grep "/home" | awk '{print $3}' | sort | uniq -c | sort -nr | head

echo "";
echo "";

echo -e "${YELLOW}${UNDERLINE}TOP direcciones IP mencionadas en log (entrantes o salientes)${NONE}";
echo "";
echo "";
grep $DIA $LOG | grep "\[" | awk -F"[" '{print $2}' | awk -F"]" '{print $1}' | sort | uniq -c | sort -nr | head

echo "";
echo "";

echo -e "${YELLOW}${UNDERLINE}TOP envíos rechazados por nueva protección de cPanel 'Reject mails for potential spammers'${NONE}";
echo "";
echo "";

grep $DIA $LOG | grep "Outgoing mail from.*has been suspended" | sed -e 's/.*\"\(.*\)\".*/\1/' | grep "@" | sort | uniq -c | sort -nr | head

echo "";
echo "";

echo -e "${YELLOW}${UNDERLINE}TOP cuentas que superaron max defers and failures per hour${NONE}"
echo "";
echo "";

grep $DIA $LOG | grep "has exceeded the max defers and failures per hour" -A3 | grep "Mail delivery failed: returning message to sender" | awk '{ print $18 }' | sort | uniq -c | sort -nr | head

echo "";
echo "";

echo -e "${YELLOW}${UNDERLINE}TOP cuentas que se quedaron sin espacio o no pueden escribir${NONE}"
echo "";
echo "";

grep $DIA $LOG | grep "Mailbox is full" |  grep -oP '\S+(?= Mailbox is full)' /var/log/exim_mainlog | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -nr | head | sed 's/<//' | sed 's/>//'

echo "";
echo "";

echo -e "${YELLOW}${UNDERLINE}TOP cuentas que enviaron correos (y quedaron en QUEUE)${NONE}"
echo "";
echo "";

exim -bpr | grep "<" | awk {'print $4'} | cut -d"<" -f2 | cut -d">" -f1 | grep '@' | sort -n | uniq -c | sort -nr | head -8

echo "";
echo "";

echo -e "${YELLOW}${UNDERLINE}TOP scripts que enviaron correos (y quedaron en QUEUE)${NONE}"
echo "";
echo "";

find /var/spool/exim/input/ -type f -exec grep 'X-PHP-Script' {} \; | cut -d':' -f2 | awk '{print $1}' | sort -n | uniq -c | sort -nr | head -10

echo "";
exit 0
