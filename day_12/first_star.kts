val input = generateSequence(::readLine)
    .joinToString("\n")

val formSizes = Regex("""\d:\n(([\#\.]+\n?)+)""")
    .findAll(input)
    .map { m ->
        m.groupValues[1].count { it == '#' }
    }
    .toList()

val grids = Regex("""(\d+)x(\d+): (.+)""")
    .findAll(input)
    .map { m ->
        Triple(
            first = m.groupValues[1].toInt(),
            second = m.groupValues[2].toInt(),
            third = m.groupValues[3].split(' ').map { it.toInt() }
        )
    }
    .toList()

val maxFormArea = 3 * 3

var easilyPossible = 0
var impossible = 0
var undetermined = 0


for(grid in grids) {
    val gridArea = grid.first * grid.second

    var bufferArea = 0
    var minimalArea = 0

    grid.third.forEachIndexed { index, amountForm ->
        bufferArea += amountForm * maxFormArea
        minimalArea += amountForm * formSizes[index]
    }

    when{
        gridArea >= bufferArea -> easilyPossible++
        gridArea < minimalArea -> impossible++
        else -> undetermined++
    }
}

println("Easily possible: $easilyPossible")
println("Impossible: $impossible")
println("Could be possible: $undetermined")
