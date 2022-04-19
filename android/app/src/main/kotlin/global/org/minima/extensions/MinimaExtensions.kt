package global.org.minima.extensions

import android.content.Context
import global.org.minima.console.ConsoleStreamHandler
import io.flutter.plugin.common.MethodCall
import org.minima.Minima

fun Minima.runCommandFromArguments(context: Context, call: MethodCall): String {
    val command: String? = call.argument("command")
    val showInConsole: Boolean? = call.argument("show_in_console")

    val commandResponse = runMinimaCMD(command)

    if (showInConsole == true) {
        ConsoleStreamHandler.getInstance(context).addMessage(command ?: "")
        ConsoleStreamHandler.getInstance(context).addMessage(commandResponse)
    }

    return commandResponse
}