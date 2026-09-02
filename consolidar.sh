#!/bin/bash
# Bucle infinito para mantener el proceso corriendo continuamente en background.
while true; do
	for archivo in $HOME/EPNro1/entrada/*.txt; do
		if [[ -f "$archivo" ]]; then
			cat "$archivo" >>"$HOME/EPNro1/salida/$FILENAME.txt"
			nombre_archivo=$(basename "$archivo") # Extrae solo el nombre sin la ruta (basename), para el log.
			fecha_hora=$(date "+%d/%m/%Y %H:%M:%S")
			echo "$fecha_hora - Procesado archivo $nombre_archivo" >>"$HOME"/EPNro1/procesado.log
			mv "$archivo" $HOME/EPNro1/procesado/
		fi
	done
	sleep 15
done
