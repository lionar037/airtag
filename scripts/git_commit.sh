#!/bin/bash

VERSION=main

# Obtener la fecha y hora actual en el formato YYYYMMDDHHMM
timestamp=$(date +'%Y%m%d%H%M')

# Construir el mensaje de commit
commit_message="update $timestamp"
echo "NAME GIT :"
echo ${commit_message}

# Ejecutar los comandos git
git add . && git commit -m "$commit_message" && git push -u origin $VERSION

# Obtener la ruta del directorio actual
PWD=$(pwd)

# Verificar que la carpeta 'scripts' existe antes de aplicar chmod
if [ -d "$PWD/scripts" ]; then
    chmod +x "$PWD/scripts"/*.sh
else
    echo "El directorio '$PWD/scripts' no existe."
fi

# Imprimir la ruta del directorio actual
echo "Ruta actual: $PWD"

#$PWD/scripts/pull_git_ssh_remote.sh
