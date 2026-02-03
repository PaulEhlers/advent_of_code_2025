val input = generateSequence(::readLine)
    .joinToString("\n")
    .replace("\r", "")
    .lines()
    .map { it.trim().replace(Regex("\\s+"), " ") }
    .filter { it.isNotBlank() }

val table = input.map { it.split(" ") }

val operations = table.last()
val rows = table.dropLast(1)

var total = 0L

for (i in operations.indices) {
    val op = operations[i]

    var cur = if (op == "*") 1L else 0L

    for (row in rows) {
        val number = row[i].toLong()
        cur = if (op == "*") cur * number else cur + number
    }

    total += cur
}

println(total)