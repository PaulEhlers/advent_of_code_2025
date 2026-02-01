val input = generateSequence(::readLine).first()

var total  = input.splitToSequence(',')
    .map { line -> line.substringBefore('-').toLong() to line.substringAfter('-').toLong() }
    .flatMap { (from, to) -> (from..to).asSequence() }
    .filter { cur ->
        val curString = cur.toString()
        val length = curString.length
        length % 2 == 0
                && curString.take(length/2) == curString.drop(length/2)
    }
    .sum()

println(total)