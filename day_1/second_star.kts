var countZeroes = 0;
var startDial = 50;

val lines = generateSequence(::readLine).toList()
lines.forEach { line ->
    val dir = line[0]
    val value = line.substring(1).toInt()

    val isMinus = dir == 'R'

    repeat(value) {
        startDial += if(isMinus) -1 else 1
        startDial %= 100

        if(startDial == 0) countZeroes++
    }

}

println(countZeroes)
