val total =
    generateSequence(::readLine)
        .sumOf { line ->
            val (final, _) = (11 downTo 0).fold(0L to 0) { (acc, leftBound), i ->
                val (leftDigit, leftIndex) = line.highestDigitInRange(leftBound until line.length - i)
                (acc * 10 + leftDigit) to (leftIndex + 1)
            }
            final
        }

println(total)

fun CharSequence.highestDigitInRange(range: IntRange) : Pair<Int,Int> {
    val index = range.maxByOrNull { this[it] } ?: return -1 to -1
    return this[index].digitToInt() to index
}