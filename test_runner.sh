#!/bin/bash

# Colores y símbolos
VERDE='\033[0;32m' ROJO='\033[0;31m' NC='\033[0m'
CHECK='✅' CRUZ='❌' MARTILLO='🔨'

verificar_requisitos() {
    if ! command -v sbt &> /dev/null; then
        echo -e "${ROJO}${CRUZ} sbt no está instalado${NC}" && exit 1
    fi
    if [ ! -f "src/main/scala/Main.scala" ]; then
        echo -e "${ROJO}${CRUZ} No se encontró Main.scala${NC}" && exit 1
    fi
}

verificar_requisitos

export SBT_OPTS="-Dsbt.color=false${SBT_OPTS:+ $SBT_OPTS}"

echo "${MARTILLO} Compilando..."
sbt -batch compile > /dev/null 2>&1 || { echo -e "${ROJO}${CRUZ} Error al compilar${NC}"; exit 1; }

echo -e "\n$ Ejecutando pruebas..."
echo "--------------------------"

exitosos=0 fallidos=0
archivo_actual=$(mktemp)
trap 'rm -f "$archivo_actual"' EXIT

shopt -s nullglob
casos=(ejemplos/inputs/*.txt)

if [ ${#casos[@]} -eq 0 ]; then
    echo -e "${ROJO}${CRUZ} No hay archivos en ejemplos/inputs/*.txt${NC}"
    exit 1
fi

while IFS= read -r archivo_input; do
    [ -n "$archivo_input" ] || continue
    nombre_caso=$(basename "$archivo_input" .txt)
    archivo_output="ejemplos/outputs/${nombre_caso}.res"

    if [ ! -f "$archivo_output" ]; then
        echo -e "${ROJO}${CRUZ} $nombre_caso: Falta ejemplos/outputs/${nombre_caso}.res${NC}"
        ((fallidos++))
        echo "--------------------------"
        continue
    fi

    # Intérprete MonaLambda: stdin desde el .txt, sin argumentos (-Dsbt.color=false vía SBT_OPTS)
    sbt -batch 'run' < "$archivo_input" 2>&1 \
        | grep -v '^\[info\]' \
        | grep -v '^\[success\]' \
        | grep -v '^\[warn\]' \
        | grep -v '^\[error\]' \
        | grep -v '^$' \
        | grep -v 'Total time' \
        | grep -v 'WARNING' \
        > "$archivo_actual"

    if cmp -s "$archivo_output" "$archivo_actual"; then
        echo -e "${VERDE}${CHECK} $nombre_caso: Prueba exitosa${NC}"
        ((exitosos++))
    else
        echo -e "${ROJO}${CRUZ} $nombre_caso: Prueba fallida${NC}"
        echo -e "${ROJO}   Esperado:${NC}"
        sed 's/^/     /' "$archivo_output"
        echo -e "${ROJO}   Recibido:${NC}"
        sed 's/^/     /' "$archivo_actual"
        ((fallidos++))
    fi
    echo "--------------------------"
done < <(printf '%s\n' "${casos[@]}" | sort)

echo -e "\n${VERDE}✔ Exitosos: $exitosos${NC}"
[ $fallidos -gt 0 ] && echo -e "${ROJO}✘ Fallidos: $fallidos${NC}"
echo

exit $((fallidos > 0))
