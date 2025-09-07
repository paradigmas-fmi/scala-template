# Ejecutor de Pruebas para Proyecto Scala con Archivos Prolog

Este proyecto incluye un script para ejecutar pruebas automatizadas de un proyecto Scala que procesa archivos de conocimiento Prolog (.pl) y consultas línea por línea.

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
│   ├── programas/           # Archivos de conocimiento Prolog (.pl)
│   │   ├── programa1.pl
│   │   ├── programa2.pl
│   │   └── ...
│   ├── input/              # Archivos de entrada con consultas
│   │   ├── programa1
│   │   ├── programa2
│   │   └── ...
│   └── output/              # Archivos de salida esperados
│       ├── programa1
│       ├── programa2
│       └── ...
├── test_runner.sh          # Script para ejecutar las pruebas
```

## Cómo Usar

1. Asegúrate de tener sbt instalado:
   ```bash
   sbt --version
   ```

2. Coloca tus archivos de prueba:
   - Los archivos de conocimiento Prolog van en `ejemplos/programas/*.pl`
   - Los archivos de entrada con consultas van en `ejemplos/inputs/*`
   - Los archivos de salida esperados van en `ejemplos/outputs/*`
   - Los nombres deben coincidir (ej: `programa1.pl`, `programa1` (en inputs), `programa1` (en outputs))

3. Dale permisos de ejecución al script:
   ```bash
   chmod +x test_runner.sh
   ```

4. Ejecuta las pruebas:
   ```bash
   ./test_runner.sh
   ```

## Formato de los Archivos de Prueba

### Archivos de Conocimiento Prolog
- Ubicación: `ejemplos/programas/*.pl`
- Formato: Sintaxis Prolog estándar
- Ejemplo:
  ```prolog
  % Hechos
  padre(juan, maria).
  padre(juan, pedro).
  
  % Reglas
  abuelo(X, Y) :- padre(X, Z), padre(Z, Y).
  ```

### Archivos de Entrada
- Ubicación: `ejemplos/inputs/*`
- Formato: Una consulta Prolog por línea
- Ejemplo:
  ```
  padre(juan, maria)
  padre(juan, pedro)
  abuelo(juan, ana)
  ```

### Archivos de Salida
- Ubicación: `ejemplos/outputs/*`
- Formato: Una respuesta por línea correspondiente a cada consulta
- Ejemplo:
  ```
  true
  true
  true
  ```

## Salida del Script

El script mostrará:
- ✅ Pruebas exitosas (verde)
- ❌ Pruebas fallidas (rojo)
- Resumen final con el total de pruebas exitosas y fallidas

Ejemplo de salida:
```
🔨 Compilando...

Ejecutando pruebas...
--------------------------
✅ programa1: Prueba exitosa
--------------------------
✅ programa2: Prueba exitosa
--------------------------

✔ Exitosos: 2
```

### Modos de Uso

**Con archivo de entrada:**
```bash
sbt "run programa.pl input.txt"
```