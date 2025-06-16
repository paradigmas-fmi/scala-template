#!/bin/bash

# Colores y símbolos
VERDE='\033[0;32m' ROJO='\033[0;31m' NC='\033[0m'
CHECK='✅' CRUZ='❌' MARTILLO='🔨' AUTO='🚗'

verificar_requisitos() {
    if ! command -v sbt &> /dev/null; then
        echo -e "${ROJO}${CRUZ} sbt no está instalado${NC}" && exit 1
    fi
    if [ ! -f "src/main/scala/Main.scala" ]; then
        echo -e "${ROJO}${CRUZ} No se encontró Main.scala${NC}" && exit 1
    fi
}

verificar_requisitos

echo "${MARTILLO} Compilando..."
sbt compile > /dev/null 2>&1 || { echo -e "${ROJO}${CRUZ} Error al compilar${NC}"; exit 1; }

echo -e "\n${AUTO} Ejecutando pruebas..."
echo "--------------------------"

exitosos=0 fallidos=0
for archivo_prueba in ejemplos/inputs/*.txt; do
    nombre_prueba=$(basename "$archivo_prueba")
    entrada=$(cat "$archivo_prueba" | tr '\n' ' ' | sed 's/ $//')
    archivo_salida="ejemplos/outputs/$nombre_prueba"
    esperado=$(cat "$archivo_salida" | tr -d '\n')

    salida=$(sbt "run $entrada" 2>/dev/null | grep -v "^\[" | grep -v "^$" | tr -d '\n')

    if [[ "$salida" == "$esperado" ]]; then
        echo -e "${VERDE}${CHECK} $nombre_prueba: '$entrada' → '$salida'${NC}"
        ((exitosos++))
    else
        echo -e "${ROJO}${CRUZ} $nombre_prueba: '$entrada'${NC}"
        echo -e "${ROJO}   Esperado: '$esperado'${NC}"
        echo -e "${ROJO}   Recibido: '$salida'${NC}"
        ((fallidos++))
    fi
    echo "--------------------------"
done

echo -e "\n${VERDE}✔ Exitosos: $exitosos${NC}"
[ $fallidos -gt 0 ] && echo -e "${ROJO}✘ Fallidos: $fallidos${NC}"
echo

exit $((fallidos > 0))
