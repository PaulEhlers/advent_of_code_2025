data class MutablePair<A, B>(var first: A, var second: B)

val lines = generateSequence(::readLine).toList()
val blank = lines.indexOfFirst { it.isBlank() }

val ranges = lines
    .take(blank)
    .map { line ->
        MutablePair(line.substringBefore("-").toLong(), line.substringAfter("-").toLong())
    }
    .sortedBy { it.first }


val total = ranges
    .drop(1)
    .fold(mutableListOf(ranges.first())) { acc, cur ->
        val last = acc.last()

        val from = last.first
        val to = last.second

        val nextFrom = cur.first
        val nextTo = cur.second

        if(nextFrom <= to) {
            val newFrom = minOf(from, nextFrom)
            val newTo = maxOf(to, nextTo)
            last.first = newFrom
            last.second = newTo
        } else {
            acc.add(cur)
        }
        acc
    }
    .sumOf { it.second - it.first + 1 }

println(total)