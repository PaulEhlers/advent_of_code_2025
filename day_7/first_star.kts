var lines = generateSequence(::readLine).toList()
val startPosition = lines.first().indexOfFirst { it == 'S' }
val height = lines.size
val alreadyHit = hashSetOf<Pair<Int, Int>>()

followBeam(startPosition, 0)

println(alreadyHit.size)

fun followBeam(x: Int, y: Int)  {
    var cur = lines[y][x];
    var curHeight = y

    while(cur != '^') {
        curHeight++
        if(curHeight >= height) return
        cur = lines[curHeight][x]
    }

    val curLoc = x to curHeight
    if(alreadyHit.add(curLoc)) {
        followBeam(x-1, curHeight)
        followBeam(x+1, curHeight)
    }
}