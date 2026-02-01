val grid = generateSequence(::readLine).toList().map { line ->
    line.replace("\r", "").map { ch -> if (ch == '@') 1 else 0 }
}

val xMax = grid.size
val yMax = grid.firstOrNull()?.size ?: 0

var total = 0
for (x in 0 until xMax) {
    for (y in 0 until yMax) {
        if (accessibleToiletPaper(x, y)) total++
    }
}

print(total)

fun accessibleToiletPaper(x: Int, y: Int): Boolean {
    if (grid[x][y] == 0) return false

    var count = 0
    for (xOff in -1..1) {
        for (yOff in -1..1) {
            if (xOff == 0 && yOff == 0) continue

            val curX = x + xOff
            val curY = y + yOff

            if (curX !in 0 until xMax) continue
            if (curY !in 0 until yMax) continue

            if (grid[curX][curY] == 1) count++
        }
    }

    return count < 4
}
