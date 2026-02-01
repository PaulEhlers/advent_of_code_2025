val total =
    generateSequence(::readLine)
        .map { line ->
            val (leftDigit, leftIndex) = highestDigitInRange(line, 0..<line.length-1)
            val (rightDigit, rightIndex) = highestDigitInRange(line, leftIndex+1..<line.length)
            leftDigit*10 + rightDigit
        }
        .sum()

println(total)

fun highestDigitInRange(input: String, range: IntRange) : Pair<Int,Int> {
    val index = range.maxByOrNull { input[it] } ?: return -1 to -1
    return input[index].digitToInt() to index
}