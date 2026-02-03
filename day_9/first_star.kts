val points = generateSequence(::readLine).map { line ->
    val (x, y) = line.split(',', limit = 2)
    x.toLong() to y.toLong()
}.toList()

var maxArea = -1L
for(i in 0 until points.size) {
    val a = points[i]
    for(j in i+1 until points.size) {
        val b = points[j]
        val area = (kotlin.math.abs(a.first - b.first) + 1) * (kotlin.math.abs(a.second - b.second) + 1)

        maxArea = maxOf(maxArea, area)
    }
}

println(maxArea)