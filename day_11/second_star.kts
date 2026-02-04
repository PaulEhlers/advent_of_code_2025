fun dfs(node: String, leftToVisit: Int = 2) : Long {
    if (node == end) return if (leftToVisit == 0) 1 else 0

    var curLeftToVisit = leftToVisit
    if(node == "fft" || node == "dac") {
        curLeftToVisit--
    }

    return memoization.getOrPut("$node : $curLeftToVisit") {
        graph[node]!!.sumOf { node -> dfs(node, curLeftToVisit) }
    }
}

val graph = generateSequence(::readLine).associate { line ->
    val (key, destinationsRaw) = (line.take(3) to line.drop(5))
    key to destinationsRaw.split(" ")
}

val memoization = mutableMapOf<String, Long>()

val start = "svr"
val end = "out"
var total = dfs(start)

println(total)