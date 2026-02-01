val input = generateSequence(::readLine).first()

var total = input.splitToSequence(',')
    .map { line -> line.substringBefore('-').toLong() to line.substringAfter('-').toLong() }
    .flatMap { (from, to) -> (from..to).asSequence() }
    .filter { cur -> isRepeatedPattern(cur.toString()) }
    .sum()

println(total)

fun isRepeatedPattern(s: String): Boolean =
    (1..s.length / 2).any { i ->
        s.length % i == 0 && s == s.take(i).repeat(s.length / i)
    }