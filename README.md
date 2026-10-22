# Plantilla de pruebas — TP2 Funco-Logi (Scala 3)

Repositorio mínimo para el motor lógico inspirado en Prolog del TP2. El programa recibe **dos argumentos**: el archivo de la base de conocimientos (`.pl`) y el archivo de consultas (una consulta por línea), e imprime por salida estándar una respuesta por cada consulta.

## Requisitos

- [sbt](https://www.scala-sbt.org/) (Scala Build Tool)
- Java compatible con Scala 3
- Unix/macOS o entorno con `bash` para `./test_runner.sh`

## Estructura del proyecto

```
.
├── src/main/scala/Main.scala   # Punto de entrada (recibe los dos paths como argumentos)
├── ejemplos/
│   ├── programas/              # Bases de conocimientos (<caso>.pl)
│   ├── inputs/                 # Consultas, una por línea (<caso>.txt)
│   └── outputs/                # Respuestas esperadas, una por línea (<caso>.res)
├── test_runner.sh
├── build.sbt
└── README.md
```

Los nombres deben coincidir: `programa1.pl` ↔ `programa1.txt` ↔ `programa1.res`.

## Cómo correr el programa

Desde la **raíz del repo**:

```bash
sbt compile
sbt "run <base_de_conocimientos.pl> <consultas.txt>"
```

Ejemplo contra un caso de ejemplo:

```bash
sbt "run ejemplos/programas/programa1.pl ejemplos/inputs/programa1.txt"
```

La salida se puede redirigir a un archivo con el operador de la shell:

```bash
sbt "run ejemplos/programas/programa1.pl ejemplos/inputs/programa1.txt" > salida.res
```

## IntelliJ / Cursor / otros IDEs

- **Pruebas automatizadas:** ejecutá `./test_runner.sh` desde una **terminal** del IDE en la carpeta raíz del proyecto.
- **Ejecutar `Main` desde el IDE:** en **IntelliJ IDEA** con plugin Scala, entrá a *Run → Edit Configurations…* → tu configuración de `Main`, y completá *Program arguments* con los dos paths (por ejemplo `ejemplos/programas/programa1.pl ejemplos/inputs/programa1.txt`).

Asegurate de tener **Working directory** = raíz del proyecto (donde está `build.sbt`), ya que los paths son relativos a ella.

## Cómo correr las pruebas de la cátedra

```bash
chmod +x test_runner.sh
./test_runner.sh
```

El script compila con `sbt compile`, ejecuta `sbt "run ejemplos/programas/<caso>.pl ejemplos/inputs/<caso>.txt"` para cada caso y compara la salida (filtrando los logs de sbt) con `ejemplos/outputs/<caso>.res`.

## Formato de los archivos de ejemplo

### Base de conocimientos (`ejemplos/programas/<caso>.pl`)

Sintaxis simplificada definida en el enunciado:

- Todas las sentencias terminan con un punto (`.`), sin espacios dentro de ellas.
- Las líneas que comienzan con `%%` son comentarios.
- Las variables comienzan con mayúscula; hechos, reglas y átomos, con minúscula.
- Los predicados de aridad 0 se escriben con paréntesis vacíos: `es_mamifero().`
- Las reglas se definen en una única línea: `cabeza(X,Y):-prop1,prop2,...,propK.`
- Operaciones built-in (`add`, `sub`, `mult`, `eq`, `gt`, `eqStr`, `len`, `not`), que pueden anidarse.

```prolog
%% Hechos
padre(juan,maria).
padre(juan,pedro).
padre(pedro,ana).

%% Reglas
abuelo(X,Y):-padre(X,Z),padre(Z,Y).
sumaYDuplica(X,Y,Z):-Z=mult(add(X,Y),2).
```

### Consultas (`ejemplos/inputs/<caso>.txt`)

Una consulta por línea, sin `?-` ni punto final:

```
abuelo(juan,ana)
padre(juan,X)
padre(P,H)
```

### Respuestas esperadas (`ejemplos/outputs/<caso>.res`)

Una respuesta por línea, en el mismo orden que las consultas:

- `true` o `false` si la consulta no tiene variables libres (o no tiene solución).
- `true [...]` con todas las soluciones, en el orden en que se encuentran, si la consulta tiene variables libres. Dentro de cada solución las variables se separan con `;`.

```
true
true [(X=maria),(X=pedro)]
true [(P=juan;H=maria),(P=juan;H=pedro),(P=pedro;H=ana)]
```

## Salida del script

- Pruebas exitosas o fallidas por caso (con el resultado esperado y el recibido)
- Resumen de cantidad de exitosos y fallidos
- Código de salida distinto de cero si hubo fallos
