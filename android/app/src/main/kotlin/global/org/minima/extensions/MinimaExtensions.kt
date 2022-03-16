package global.org.minima.extensions

import global.org.minima.console.ConsoleStreamHandler
import io.flutter.plugin.common.MethodCall
import org.minima.Minima

fun Minima.runCommandFromArguments(call: MethodCall): String {
    val command: String? = call.argument("command")
    val showInConsole: Boolean? = call.argument("show_in_console")

    val commandResponse = runMinimaCMD(command)

    if (showInConsole == true) {
        ConsoleStreamHandler.instance.addMessage(command ?: "")
        ConsoleStreamHandler.instance.addMessage(commandResponse)
    }

    return commandResponse
}