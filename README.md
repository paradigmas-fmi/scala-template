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

## stdin y sbt (`fork` + `connectInput`)

El proyecto declara en `build.sbt`:

```scala
Compile / run / fork := true
Compile / run / connectInput := true
```

**Por qué:** si `fork` es `false` (valor histórico de sbt), `run` ejecuta `Main` **dentro de la JVM de sbt**. En ese modo la entrada estándar **no tiene por qué** ser la del proceso que invocaste (en la práctica viene vacía o se comporta mal con `run < archivo`, WSL y algunos IDEs).

Con **`fork := true`** el programa corre en otro proceso Java y **`connectInput := true`** le enchufa ese mismo stdin que recibe sbt desde la terminal o la redirección `< archivo`.

`Source.stdin.getLines()` y `StdIn.readLine()` son válidos cuando está bien conectado el stdin; cualquiera de los dos debería servir junto con la configuración anterior.

## Cómo correr el intérprete

Desde la **raíz del repo**:

```bash
sbt compile
sbt run < mi_entrada.txt
```

Ejemplo contra un caso de ejemplo:

```bash
sbt run < ejemplos/inputs/omega_cbn.txt
```

En una sola invocación (abre sbt, ejecuta `compile` y termina):

```bash
sbt "compile; run" < mi_entrada.txt
```

### ¿Hace falta `--batch`?

**No es obligatorio** para los comandos que usamos acá.

Si escribís `sbt compile` o `sbt run` desde la terminal **con el comando después de `sbt`**, ese proceso ejecuta esa tarea y **sale**, sin quedar en modo interactivo. El flag `--batch` (“disable interactive mode” en `sbt --help`) suele usarlo la gente en scripts **muy genéricos** o versiones viejas del launcher.

En **Windows/WSL/Git Bash** algunos equipos reportan que **`sbt --batch run < archivo`** (o `-batch`) no les entrega bien el stdin junto con `fork` + redirección, mientras que **`sbt run < archivo`** sí. Por eso el script `./test_runner.sh` **ya no usa** `--batch`. Si en tu máquina funciona igual, podés usarlo opcionalmente:

```bash
sbt --batch run < ejemplos/inputs/omega_cbn.txt
```

Si no anda el `run` con `--batch`, usá la forma sin `--batch` (como el script de la cátedra).

## IntelliJ / Cursor / otros IDEs

- **Pruebas automatizadas:** ejecutá `./test_runner.sh` desde una **terminal** del IDE en la carpeta raíz del proyecto.
- **Ejecutar `Main` con archivo de entrada:** el botón “Run” típico **no** redirige un `.txt` a stdin salvo que lo configures en la corrida.

En **IntelliJ IDEA** con plugin Scala:

1. *Run → Edit Configurations…* → tu configuración de `Main`.
2. *Modify options → Redirect input from* y elegís el archivo `.txt`.

Si no aparece esa opción, usá una terminal dentro del IDE y el comando `sbt run < ejemplos/inputs/omega_cbn.txt`.

Asegurate de tener **Working directory** = raíz del proyecto (donde está `build.sbt`).

## Cómo correr las pruebas de la cátedra

```bash
chmod +x test_runner.sh
./test_runner.sh
```

El script exporta `SBT_OPTS=-Dsbt.color=false` (para logs sin ANSI), compila con `sbt compile`, ejecuta `sbt run` redirigiendo cada `ejemplos/inputs/<caso>.txt` a stdin (**sin** `--batch`, por compatibilidad de stdin en algunos entornos) y compara la salida filtrada (líneas `[info]` / `[success]` de sbt, etc.) con `ejemplos/outputs/<caso>.res`.

## Formato de los archivos de ejemplo

- **`ejemplos/inputs/<caso>.txt`**: texto UTF-8, una instrucción por línea (sin prompts).
- **`ejemplos/outputs/<caso>.res`**: lo que debe imprimirse a **stdout**, línea a línea, en el mismo orden que las respuestas a cada instrucción.

Los nombres deben coincidir: `foo.txt` ↔ `foo.res`.

## Salida del script

- Pruebas exitosas o fallidas por caso
- Resumen de cantidad de exitosos y fallidos
- Código de salida distinto de cero si hubo fallos
