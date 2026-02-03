import kotlin.collections.map

val linesRaw = generateSequence(::readLine)
    .map { it.replace("\r", "") }
    .toList()

val operationLine = linesRaw.last()

val startIndexes = mutableListOf<Int>()
val operations = mutableListOf<Char>()
val opRegex = Regex("[*+]")
opRegex.findAll(operationLine).forEach { m ->
    startIndexes += m.range.first
    operations += m.value[0]
}

val longestLineIndex = linesRaw.maxOf { it.length - 1 }
startIndexes += longestLineIndex

val paddedLines = linesRaw.map { line ->
    line.padEnd(longestLineIndex + 1, ' ')
}

val height = paddedLines.size - 1
val grid = paddedLines.map { it.toCharArray() }

var total = 0L

for (i in operations.indices) {
    val op = operations[i]
    val isMultiplication = op == '*'

    val index = startIndexes[i]
    var nextIndex = startIndexes[i + 1]
    val isLast = i == operations.lastIndex

    nextIndex = if (isLast) nextIndex + 1 else nextIndex - 1

    var cur = if (isMultiplication) 1L else 0L

    for (j in index until nextIndex) {
        val numberStr = buildString {
            for (k in 0 until height) {
                append(grid[k][j])
            }
        }

        val number = numberStr.trim().toLong()
        cur = if (isMultiplication) cur * number else cur + number
    }

    total += cur
}

println(total)