object Main {
  def main(args: Array[String]): Unit = {
    val name = if (args.length > 0) args(0) else "unknown"
    val year = if (args.length > 1) args(1) else "unknown"
    println(s"Car: $name - $year")
  }
}
