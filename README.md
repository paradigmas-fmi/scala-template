# Plantilla de pruebas — TP1 MonaLambda (Scala 3)

Repositorio mínimo para el intérprete de cálculo lambda del TP1. El programa debe leer **líneas por la entrada estándar** (definiciones `NOMBRE=expr`, `calc_vars`, `reduce cbn|cbv`, etiquetas `!NOMBRE`, etc.), según el enunciado.

## Requisitos

- [sbt](https://www.scala-sbt.org/) (Scala Build Tool)
- Java compatible con Scala 3
- Unix/macOS o entorno con `bash` para `./test_runner.sh`

## Estructura del proyecto

```
.
├── src/main/scala/Main.scala   # Punto de entrada (stdin)
├── ejemplos/
│   ├── inputs/                 # Casos de prueba: una línea = una orden al intérprete
│   └── outputs/                # Salida esperada en stdout (.res con el mismo nombre base)
├── test_runner.sh
├── build.sbt
└── README.md
```

## Cómo correr el intérprete

Desde la raíz del proyecto, compilá y ejecutá **sin argumentos**; escribí órdenes por stdin (o redirigí un archivo):

```bash
sbt compile
sbt run < mi_entrada.txt
```

En una sola invocación:

```bash
sbt -batch run < mi_entrada.txt
```

## Cómo correr las pruebas de la cátedra

```bash
chmod +x test_runner.sh
./test_runner.sh
```

El script exporta `SBT_OPTS=-Dsbt.color=false` (para logs sin ANSI), compila con `sbt -batch compile`, ejecuta `sbt -batch run` redirigiendo cada `ejemplos/inputs/<caso>.txt` a stdin y compara la salida filtrada (líneas `[info]` / `[success]` de sbt, etc.) con `ejemplos/outputs/<caso>.res`.

## Formato de los archivos de ejemplo

- **`ejemplos/inputs/<caso>.txt`**: texto UTF-8, una instrucción por línea (sin prompts).
- **`ejemplos/outputs/<caso>.res`**: lo que debe imprimirse a **stdout**, línea a línea, en el mismo orden que las respuestas a cada instrucción.

Los nombres deben coincidir: `foo.txt` ↔ `foo.res`.

## Salida del script

- Pruebas exitosas o fallidas por caso
- Resumen de cantidad de exitosos y fallidos
- Código de salida distinto de cero si hubo fallos
