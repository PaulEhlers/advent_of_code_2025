var lines = generateSequence(::readLine).toList()

val blank = lines.indexOfFirst { it.isBlank() }

val ranges = lines
    .take(blank)
    .map { line ->
        line.substringBefore("-").toLong() to line.substringAfter("-").toLong()
    }

val total = lines
    .drop(blank + 1)
    .count { line ->
        val ingredientNumber = line.toLong()
        ranges.any { it.first <= ingredientNumber && it.second >= ingredientNumber }
    }

println(total)