object Main {
  def main(args: Array[String]): Unit = {
    // TP1 MonaLambda: una línea por stdin (definiciones, calc_vars, reduce, …).
    // En build.sbt: fork + connectInput para que stdin funcione con `sbt run < archivo`.
    Iterator
      .continually(scala.io.StdIn.readLine())
      .takeWhile(_ != null)
      .foreach(_ => ()) // Implementación del intérprete: grupo
  }
}
