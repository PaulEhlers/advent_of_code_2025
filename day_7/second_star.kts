val lines = generateSequence(::readLine).toList()
val startPosition = lines.first().indexOfFirst { it == 'S' }
var beams = mutableMapOf(startPosition to 1L)
var total = 1L

for (row in 0 until lines.lastIndex) {
    var nextBeams = hashMapOf<Int, Long>()
    for ((beamPosition, count) in beams) {
        val peek = lines[row+1][beamPosition]
        when(peek) {
            '^' -> {
                total += count
                nextBeams[beamPosition+1] = nextBeams.getOrDefault(beamPosition+1, 0L) + count
                nextBeams[beamPosition-1] = nextBeams.getOrDefault(beamPosition-1, 0L) + count
            }
            '.' -> {
                nextBeams[beamPosition] = nextBeams.getOrDefault(beamPosition, 0L) + count
            }
        }
    }
    beams = nextBeams
}

println(total)
