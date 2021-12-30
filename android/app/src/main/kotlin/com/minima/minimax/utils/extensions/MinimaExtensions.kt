package com.minima.minimax.utils.extensions

import com.jraska.console.Console
import io.flutter.plugin.common.MethodCall
import org.minima.Minima

fun Minima.runCommandFromArguments(call: MethodCall): String {
    val command: String? = call.argument("command")
    val showInConsole: Boolean? = call.argument("show_in_console")

    val commandResponse = runMinimaCMD(command)

    if (showInConsole == true) {
        Console.writeLine(command)
        Console.writeLine(commandResponse)
    }

    return commandResponse
}