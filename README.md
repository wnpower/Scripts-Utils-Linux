# Scripts-Utils-Linux
Conjunto utilidades para Linux.
# Utilidades
## du.sh
Script que muestra el top 10 de directorios con sus consumos en disco.
### Modo de uso
	wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/du.sh
	bash du.sh /path_a_verificar
	
## fix_journald.sh
Script que repara journald (síntoma: los servicios no loggean correctamente).
### Modo de uso
	wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/fix_journald.sh
	bash fix_journald.sh

## exim_smtp_log.sh
Genera un reporte usando el log de Exim para encontrar cuentas que hayan enviado SPAM. Si se usa un argumento numérico, analiza días anteriores
### Modo de uso
	wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/exim_smtp_log.sh
        bash exim_smtp_log.sh

## exim_vaciar_queue.sh
Elimina los correos de la queue de Exim (se puede seleccionar sólo eliminar una cuenta en específico)
### Modo de uso
        wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/exim_vaciar_queue.sh
        bash exim_vaciar_queue.sh

## exim_vaciar_queue_forzado.sh
Elimina los correos y base de datos de Exim (se usa en casos donde hay tanto SPAM que no se puede eliminar con el script anterior o demora mucho)
### Modo de uso
        wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/exim_vaciar_queue_forzado.sh
        bash exim_vaciar_queue_forzado.sh

## vps/fix_var_run_symlinks.sh
Script que repara bug de cPanel cuando se reinicia un servicio mostrando "Too many levels of symbolic links".
### Modo de uso
	wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/vps/fix_var_run_symlinks.sh
	bash fix_var_run_symlinks.sh
