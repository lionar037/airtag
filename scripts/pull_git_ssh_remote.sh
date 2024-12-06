#!/bin/bash

LINK=/home/pi/src/airtag/
#DEVICES=("pi@raspberrypi.local" "pi@moquitto.local" "pi@raspberry.local")
#DEVICES=("pi@raspberrypi.local" "pi@moquitto.local" )
#DEVICES=("pi@raspberry.local")
DEVICES=("pi@raspberry.local" )

for DEVICE in "${DEVICES[@]}"; do
    ssh "$DEVICE" "cd $LINK && git pull"
done

# Obtener la ruta del directorio actual
PWD=$(pwd)

# Verificar que la carpeta 'scripts' existe antes de aplicar chmod
if [ -d "$PWD/scripts" ]; then
    chmod +x "$PWD/scripts"/*.sh
else
    echo "El directorio '$PWD/scripts' no existe."
fi

# Imprimir la ruta del directorio actual
echo -e "Ruta actual: \n $PWD"