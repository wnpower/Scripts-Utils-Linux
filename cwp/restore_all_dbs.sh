#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

if [ $# -eq 0 ]; then
	echo "Modo de uso: $0 PATH_BACKUPS"
	echo "Ejemplo: $0 /backup/mysql/daily"
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "No existe la carpeta $1"
	exit 1
fi

BASE_PATH="$1"

# DESCOMPRIMIR SI ESTAN COMPRIMIDAS
find $BASE_PATH -maxdepth 1 -type f -name "*.sql.gz" | while read FILE
do
	echo "Descomprimiendo $FILE..."
	gunzip $FILE
done

find $BASE_PATH -maxdepth 1 -type f -name "*.sql" | while read FILE
do
	ARCHIVO=$(basename $FILE)
	NOMBRE_DB=$(echo $ARCHIVO | sed 's/.sql$//')
	echo "Restaurando $ARCHIVO..."

	echo "CREATE DATABASE $NOMBRE_DB" | mysql
	mysql $NOMBRE_DB < $FILE
done
