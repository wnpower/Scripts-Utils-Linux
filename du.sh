#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
if [ $# -ne 1 ]; then
	echo "Muestra los 10 directorios que mas consumen"
	echo "Modo de uso: $0 DIRECTORIO"
	exit 1
fi

if [ ! -d $1 ]; then
	echo "El directorio $1 no existe"
	exit 1
fi

cd $1 && du -hsx -- .[!.]* * 2>/dev/null | sort -rh | head -10
