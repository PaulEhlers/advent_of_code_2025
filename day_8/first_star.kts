data class Point3D(val x: Long, val y: Long, val z: Long) {
    fun distance(other: Point3D): Double {
        val dx = (x - other.x).toDouble()
        val dy = (y - other.y).toDouble()
        val dz = (z - other.z).toDouble()
        return kotlin.math.sqrt(dx*dx + dy*dy + dz*dz)
    }
}

data class Point3DPair(
    val a: Int,
    val b: Int,
    val distance: Double,
)

class DSU(n: Int) {
    val parents = IntArray(n) { it }

    fun find(x: Int): Int {
        if (parents[x] != x) parents[x] = find(parents[x])
        return parents[x]
    }

    fun union(a: Int, b: Int): Boolean {
        val ra = find(a)
        val rb = find(b)
        if (ra != rb) {
            parents[rb] = ra
            return true
        }
        return false
    }
}

var points = generateSequence(::readLine)
    .map { line ->
        val (x, y, z) = line.split(',', limit = 3)
        Point3D(
            x = x.toLong(),
            y = y.toLong(),
            z = z.toLong(),
        )
    }
    .toList()

var pointPairs =  mutableListOf<Point3DPair>()
for(i in 0 until points.size) {
    for(j in i+1 until points.size) {
        pointPairs.add(
            Point3DPair(
                a = i,
                b = j,
                distance = points[i].distance(points[j])
            )
        )
    }
}
pointPairs.sortBy { it.distance }

val target = 1000
val dsu = DSU(target)

repeat(target) { i ->
    val curPair = pointPairs[i]
    dsu.union(curPair.a, curPair.b)
}

val sortedValues = dsu.parents.indices
    .groupingBy { id -> dsu.find(id) }
    .eachCount()
    .values
    .sortedDescending()
    .take(3)

println(sortedValues[0] * sortedValues[1] * sortedValues[2])
