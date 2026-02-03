fun <T : Comparable<T>> minMax(a: T, b: T): Pair<T, T> =
    if (a <= b) a to b else b to a

data class RedRectangle(
    val a: Pair<Int, Int>,
    val b: Pair<Int, Int>,
    val area: Long,
) {

    fun intersects(lineFrom: Pair<Int, Int>, lineTo: Pair<Int, Int>): Boolean {
        val(redMinX, redMaxX) = minMax(a.first, b.first)
        val(redMinY, redMaxY) = minMax(a.second, b.second)

        val(lineMinX, lineMaxX) = minMax(lineFrom.first, lineTo.first)
        val(lineMinY, lineMaxY) = minMax(lineFrom.second, lineTo.second)

        return lineMaxX > redMinX
                && redMaxX > lineMinX
                && lineMaxY > redMinY
                && redMaxY > lineMinY
    }
}

fun intersectsPerimeter(a: RedRectangle): Boolean {
    for(i in 0 until points.size) {
        val lineFrom = points[i]
        val lineTo = points[(i + 1).mod(points.size)]

        if(a.intersects(lineFrom, lineTo)) {
            return true
        }
    }
    return false
}

val points = generateSequence(::readLine).map { line ->
    val (x, y) = line.split(',', limit = 2)
    x.toInt() to y.toInt()
}.toList()

var redRectanglesOrdered = mutableListOf<RedRectangle>()
for(i in 0 until points.size) {
    val a = points[i]
    for(j in i + 1 until points.size) {
        val b = points[j]
        val area = (kotlin.math.abs(a.first - b.first) + 1).toLong() * (kotlin.math.abs(a.second - b.second) + 1).toLong()

        redRectanglesOrdered.add(
            RedRectangle(
                a = a,
                b = b,
                area = area,
            )
        )
    }
}
redRectanglesOrdered.sortByDescending { it.area }

for(redRectangle in redRectanglesOrdered) {
    if(!intersectsPerimeter(redRectangle)) {
        println(redRectangle.area)
        break;
    }
}



