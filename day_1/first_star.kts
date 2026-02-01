var countZeroes = 0
var startDial = 50

val lines = generateSequence(::readLine).toList()
lines.forEach { line ->
    val dir = line[0]
    val value = line.substring(1).toInt()

    val isMinus = dir == 'R'

    startDial += if(isMinus) -value else value
    startDial %= 100

    if(startDial == 0) countZeroes++
}

println(countZeroes)
