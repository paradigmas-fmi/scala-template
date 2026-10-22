object Main {
  def main(args: Array[String]): Unit = {
    if (args.length < 2) {
      System.err.println("Uso: sbt \"run <base_de_conocimientos.pl> <consultas.txt>\"")
      System.exit(1)
    }

    val archivoConocimiento = args(0)
    val archivoConsultas = args(1)

    // Verificar que el archivo de conocimiento existe y termina en .pl
    if (!archivoConocimiento.endsWith(".pl")) {
      System.err.println("Error: El archivo de conocimiento debe terminar en .pl")
      System.exit(1)
    }

    val archivo = new java.io.File(archivoConocimiento)
    if (!archivo.exists()) {
      System.err.println(s"Error: No se encontró el archivo $archivoConocimiento")
      System.exit(1)
    }

    val archivoEntrada = new java.io.File(archivoConsultas)
    if (!archivoEntrada.exists()) {
      System.err.println(s"Error: No se encontró el archivo $archivoConsultas")
      System.exit(1)
    }

    // Cargar el archivo de conocimiento
    val conocimiento = scala.io.Source.fromFile(archivo).getLines().toList

    // Procesar las consultas línea por línea: una respuesta por cada consulta
    scala.io.Source.fromFile(archivoEntrada).getLines().foreach { consulta =>
      println(procesarConsulta(consulta.trim, conocimiento))
    }
  }

  def procesarConsulta(consulta: String, conocimiento: List[String]): String = {
    // Esta función debe implementar la lógica del TP.
    // Debe devolver "false", "true" o "true [(X=valor;...),...]" según el enunciado.
    "false"
  }
}
