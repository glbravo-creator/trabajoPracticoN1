#!/bin/bash

# Defino las variables locales
EPDIR="$HOME/EPNro1"
ENTRADA="$EPDIR/entrada"
SALIDA="$EPDIR/salida"
PROCESADO="$EPDIR/procesado"
LOG="$EPDIR/procesado.log"
CONSOLIDAR="$EPDIR/consolidar.sh"

# Eliminar entorno con -d
if [[ $1 == "-d" ]]; then
	echo "Eliminando estructura y apagando procesos...."
	pkill -f consolidar.sh
	rm -rf $EPDIR
else
	opcion=""
	while [[ $opcion != "7" ]]; do
		# Despliegue de Menú y toma de datos
		echo "---MENÚ---"
		echo "1) Crear entorno"
		echo "2) Correr proceso"
		echo "3) Ordenar por número de padrón"
		echo "4) Top 10 notas mas altas"
		echo "5) Buscar alumno por padrón"
		echo "6) Visualizar log"
		echo "7) Salir"
		echo -n "Seleccione una opción: "
		read opcion
		# Procesamiento de opciones con case
		case $opcion in
		1)
			mkdir -p "$ENTRADA"
			mkdir -p "$SALIDA"
			mkdir -p "$PROCESADO"
			cp consolidar.sh $EPDIR
			chmod +x $HOME/EPNro1/consolidar.sh
			echo -e "Entorno creado!\n"
			;;
		2)
			if pgrep -f "consolidar.sh" >/dev/null; then # Verifica si corre el proceso y silencia la salida (/dev/null)
				echo -e "El proceso consolidar.sh ya está ejecutado en background.\n"
			else
				nohup "$CONSOLIDAR" >> "$EPDIR/consolidar.out" 2>&1 &
				echo -e "Proceso consolidar.sh iniciado en background.\n"
			fi
			;;
		3)
			if [[ -f "$SALIDA/$FILENAME.txt" ]]; then
				sort -n "$SALIDA/$FILENAME.txt"
			else
				echo -e "No existe $FILENAME.txt o no se creo aún.\n"
			fi
			;;
		4) # Formato esperado: campos separados por espacios/tabs (la nota debe ser la columna 5).
			if [[ -f "$SALIDA/$FILENAME.txt" ]]; then
				sort -rn -k5 "$SALIDA/$FILENAME.txt" | head -10
			else
				echo -e "No existe $FILENAME.txt en la carpeta salida.\n"
			fi
			;;
		5)
			if [[ -f "$SALIDA/$FILENAME.txt" ]]; then
				echo -n "Ingrese el número de padrón a buscar: "
				read padron
				resultado=$(grep -w "^$padron" "$SALIDA/$FILENAME.txt") # ^ busca al inicio del renglón y -w el padrón exacto.
				if [[ -n "$resultado" ]]; then
					echo "$resultado"
				else
					echo -e "No se encontro el padrón $padron.\n"
				fi
			else
				echo -e "No existe $FILENAME.txt en la carpeta salida.\n"
			fi
			;;
		6)
			if [[ -f "$LOG" ]]; then
				cat "$LOG"
			else
				echo -e "Aun no existe el archivo de log.\n"
			fi
			;;
		7)
			echo -e "Saliendo...\n"
			;;
		*)
			echo -e "Opción no válida\n"
			;;
		esac
	done
fi
