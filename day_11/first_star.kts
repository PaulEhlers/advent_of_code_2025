fun dfs(node: String) {
    val nextNodes = graph[node]!!

    if(nextNodes[0] == end) {
        total++
        return
    }

    for(nextNode in nextNodes) {
        dfs(nextNode)
    }
}

val graph = generateSequence(::readLine).associate { line ->
    val (key, destinationsRaw) = (line.take(3) to line.drop(5))
    key to destinationsRaw.split(" ")
}

val start = "you"
val end = "out"
var total = 0;

dfs(start)

println(total)