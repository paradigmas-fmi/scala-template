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

# Logs de sbt sin colores ANSI, para poder filtrarlos de la salida del programa
export SBT_OPTS="-Dsbt.color=false${SBT_OPTS:+ $SBT_OPTS}"

echo "${MARTILLO} Compilando..."
sbt compile > /dev/null 2>&1 || { echo -e "${ROJO}${CRUZ} Error al compilar${NC}"; exit 1; }

echo -e "\n$ Ejecutando pruebas..."
echo "--------------------------"

exitosos=0 fallidos=0

# Buscar todos los programas en ejemplos/programas/
for programa in ejemplos/programas/*.pl; do
    if [ ! -f "$programa" ]; then
        continue
    fi
    
    nombre_programa=$(basename "$programa" .pl)
    archivo_input="ejemplos/inputs/${nombre_programa}.txt"
    archivo_output="ejemplos/outputs/${nombre_programa}.res"
    
    # Verificar que existen los archivos de entrada y salida
    if [ ! -f "$archivo_input" ] || [ ! -f "$archivo_output" ]; then
        echo -e "${ROJO}${CRUZ} $nombre_programa: Faltan archivos input/output${NC}"
        ((fallidos++))
        continue
    fi
    
    # Ejecutar el programa con el archivo de conocimiento y archivo de input como parámetros
    salida=$(sbt "run $programa $archivo_input" 2>/dev/null | grep -v "^\[" | grep -v "^$" | grep -v "Total time" | grep -v "WARNING")
    esperado=$(cat "$archivo_output")
    
    # Comparar línea por línea
    if [[ "$salida" == "$esperado" ]]; then
        echo -e "${VERDE}${CHECK} $nombre_programa: Prueba exitosa${NC}"
        ((exitosos++))
    else
        echo -e "${ROJO}${CRUZ} $nombre_programa: Prueba fallida${NC}"
        echo -e "${ROJO}   Esperado:${NC}"
        echo "$esperado" | sed 's/^/     /'
        echo -e "${ROJO}   Recibido:${NC}"
        echo "$salida" | sed 's/^/     /'
        ((fallidos++))
    fi
    echo "--------------------------"
done

echo -e "\n${VERDE}✔ Exitosos: $exitosos${NC}"
[ $fallidos -gt 0 ] && echo -e "${ROJO}✘ Fallidos: $fallidos${NC}"
echo

exit $((fallidos > 0))
