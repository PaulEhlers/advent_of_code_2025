data class Machine(
    val indicatorLights: List<Boolean>,
    val buttons: List<List<Int>>,
    val joltages: List<Int>,
)

data class LightState(val depth: Int, val lights: MutableList<Boolean>)

val machines = generateSequence(::readLine).map { line ->
    val indicatorRegex = Regex("""\[(.+)\]""")
    val indicatorLights = indicatorRegex.find(line)!!.groupValues[1].map {
        it == '#'
    }

    val buttonRegex = Regex("""\(([\d\,]+)\)""")
    val buttons = buttonRegex.findAll(line).map { m ->
        m.groupValues[1].split(',').map {
            it.toInt()
        }
    }.toList()

    val joltageRegex = Regex("""\{([\d\,]+)\}""")
    val joltages = joltageRegex.find(line)!!.groupValues[1].split(',').map {
        it.toInt()
    }

    Machine(
        indicatorLights = indicatorLights,
        buttons = buttons,
        joltages = joltages,
    )
}.toList()

val total = machines.sumOf { machine ->
    val indicatorLights = machine.indicatorLights
    val currentLights = indicatorLights.map { false }
    val buttons = machine.buttons

    val queue: ArrayDeque<LightState> = ArrayDeque()
    queue.add(LightState(depth = 0, currentLights.toMutableList()))

    while(!queue.isEmpty()) {
        val current = queue.removeFirst()

        for(button in buttons) {
            val newCombination = LightState(
                depth = current.depth+1,
                lights = current.lights.toMutableList()
            )

            for(buttonPress in button) {
                newCombination.lights[buttonPress] = !newCombination.lights[buttonPress]
            }

            if(indicatorLights == newCombination.lights) {
                return@sumOf newCombination.depth
            }

            queue.addLast(newCombination)
        }
    }
    0
}

println(total)