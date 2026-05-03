ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "3.3.6"

lazy val root = (project in file("."))
  .settings(
    name := "Scala-template",
    // Sin esto, sbt ejecuta Main en la misma JVM que el propio sbt y stdin suele llegar mal o vacío
    // cuando se usa `sbt run < entrada.txt`, el script Bash o terminales/IDE tipo IntelliJ/WSL.
    Compile / run / fork := true,
    Compile / run / connectInput := true,
  )
