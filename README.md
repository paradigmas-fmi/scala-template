# Ejecutor de Pruebas para Proyecto Scala

Este proyecto incluye un script para ejecutar pruebas automatizadas de un proyecto Scala.

## Requisitos

- [sbt](https://www.scala-sbt.org/) (Scala Build Tool)
- Java 8 o superior
- Sistema operativo Unix/Linux/macOS (el script usa comandos bash)

## Estructura del Proyecto

```
.
├── src/
│   └── main/
│       └── scala/
│           └── Main.scala    # Código fuente principal
├── ejemplos/
│   ├── inputs/              # Archivos de entrada para las pruebas
│   │   ├── test1.txt
│   │   ├── test2.txt
│   │   └── ...
│   └── outputs/             # Archivos de salida esperados
│       ├── test1.txt
│       ├── test2.txt
│       └── ...
├── test_runner.sh          # Script para ejecutar las pruebas
```

## Cómo Usar

1. Asegúrate de tener sbt instalado:
   ```bash
   sbt --version
   ```

2. Coloca tus archivos de prueba:
   - Los archivos de entrada van en `ejemplos/inputs/`
   - Los archivos de salida esperados van en `ejemplos/outputs/`
   - Los nombres de los archivos deben coincidir (ej: `test1.txt` en inputs y outputs)

3. Dale permisos de ejecución al script:
   ```bash
   chmod +x test_runner.sh
   ```

4. Ejecuta las pruebas:
   ```bash
   ./test_runner.sh
   ```

## Formato de los Archivos de Prueba

### Archivos de Entrada
- Ubicación: `ejemplos/inputs/*.txt`
- Formato: Una línea por prueba
- Ejemplo:
  ```
  Toyota 2021
  ```

### Archivos de Salida
- Ubicación: `ejemplos/outputs/*.txt`
- Formato: Una línea con la salida esperada
- Ejemplo:
  ```
  Car: Toyota - 2021
  ```

## Salida del Script

El script mostrará:
- ✅ Pruebas exitosas (verde)
- ❌ Pruebas fallidas (rojo)
- Resumen final con el total de pruebas exitosas y fallidas

Ejemplo de salida:
```
🔨 Compilando...

🚗 Ejecutando pruebas...
--------------------------
✅ test1.txt: 'Toyota 2021' → 'Car: Toyota - 2021'
--------------------------
❌ test2.txt: 'Ford 1999'
   Esperado: 'Car: Ford - 1999'
   Recibido: 'Car: unknown - unknown'
--------------------------

✔ Exitosos: 1
✘ Fallidos: 1
```
