# Scripts-Utils-Linux
Conjunto utilidades para Linux.
# Utilidades
## du.sh
Script que muestra el top 10 de directorios con sus consumos en disco.
### Modo de uso
	wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/du.sh && chmod 755 du.sh
	./du.sh /path_a_verificar
	
## fix_journald.sh
Script que repara journald (síntoma: los servicios no loggean correctamente).
### Modo de uso
	wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/fix_journald.sh && chmod 755 fix_journald.sh
	./fix_journald.sh

## vps/fix_var_run_symlinks.sh
Script que repara bug de cPanel cuando se reinicia un servicio mostrando "Too many levels of symbolic links".
### Modo de uso
	wget https://raw.githubusercontent.com/wnpower/Scripts-Utils-Linux/master/vps/fix_var_run_symlinks.sh && chmod 755 fix_var_run_symlinks.sh
	./fix_var_run_symlinks.sh
