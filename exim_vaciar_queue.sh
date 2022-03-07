#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

echo "";
echo "";

echo -n "Especifique la cuenta que envió SPAM así se borran sólo esos mails [T para borrar todo]: "
read ACCT

if [ "$ACCT" = "T" ] || [ "$ACCT" = "t" ]; then
        exim -bpru | awk {'print $3'} | xargs exim -Mrm
elif [[ "$ACCT" =~ @ ]]; then
        exiqgrep -i -r "$ACT" | xargs exim -Mrm
        exiqgrep -i -f "$ACT" | xargs exim -Mrm
else
        echo "$ACCT no es una opción válida"
        exit 1
fi

echo "Mails en cola ahora...";

exim -bpc

echo "";
echo "";

echo "Finalizado"
