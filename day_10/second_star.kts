import com.microsoft.z3.*

data class Machine(
    val indicatorLights: List<Boolean>,
    val buttons: List<List<Int>>,
    val joltages: List<Int>,
)

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
    val joltages = machine.joltages
    val buttons = machine.buttons

    val ctx = Context()
    val optimizer = ctx.mkOptimize()

    val vars = List(buttons.size) { i -> ctx.mkIntConst("x$i") }
    for (v in vars) optimizer.Add(ctx.mkGe(v, ctx.mkInt(0)))

    for(i in 0 until joltages.size) {
        val curVars = mutableListOf<IntExpr>()
        for(j in 0 until buttons.size) {
            if(buttons[j].any { it == i }) {
                curVars.add(vars[j])
            }
        }

        optimizer.Add(
            ctx.mkEq(
                ctx.mkAdd(*curVars.toTypedArray()),
                ctx.mkInt(joltages[i])
            )
        )
    }

    val minimumPresses = ctx.mkIntConst("x")
    val sum = ctx.mkAdd(*vars.toTypedArray())
    optimizer.Add(ctx.mkEq(sum, minimumPresses))
    optimizer.MkMinimize(minimumPresses)

    val status = optimizer.Check()
    if(status == Status.SATISFIABLE) {
        optimizer.model.evaluate(minimumPresses, false).toString().toInt()
    } else {
        0
    }

}

println(total)