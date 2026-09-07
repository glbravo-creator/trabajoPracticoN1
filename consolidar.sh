#!/bin/bash

EPDIR="$HOME/EPNro1"
ENTRADA="$EPDIR/entrada"
SALIDA="$EPDIR/salida"
PROCESADO="$EPDIR/procesado"
LOG="$EPDIR/procesado.log"
INTERVALO=15

# Bucle infinito para mantener el proceso corriendo continuamente en background.
while true; do
	for archivo in $ENTRADA/*.txt; do
		if [[ -f "$archivo" ]]; then
			cat "$archivo" >>"$SALIDA/$FILENAME.txt"
			nombre_archivo=$(basename "$archivo") # Extrae solo el nombre sin la ruta (basename), para el log.
			fecha_hora=$(date "+%d/%m/%Y %H:%M:%S")
			echo "$fecha_hora - Procesado archivo $nombre_archivo" >> "$HOME"/EPNro1/procesado.log
			mv "$archivo" $PROCESADO
		fi
	done
	sleep "$INTERVALO"
done
