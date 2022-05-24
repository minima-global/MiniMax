package global.org.minima.console

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import global.org.minima.extensions.orElse
import io.flutter.plugin.common.EventChannel

class ConsoleStreamHandler(private val context: Context) : EventChannel.StreamHandler {
    private var events: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        events?.success(buffer.getMessages())
        this.events = events
    }

    override fun onCancel(arguments: Any?) {
        // NO-OP
    }

    fun addMessage(message: String) {
        context.runOnUiThread {
            events?.success(buffer.addMessage(message))
        }
    }

    fun clearMessages() {
        context.runOnUiThread {
            events?.success(buffer.clearMessages())
        }
    }

    companion object {
        private val buffer = ConsoleBuffer()

        @SuppressLint("StaticFieldLeak")
        // Unless we use some dependency injection
        private var instance: ConsoleStreamHandler? = null

        fun getInstance(context: Context) = instance.orElse {
            return@orElse ConsoleStreamHandler(context).apply {
                instance = this
            }
        }
    }

    private fun Context.runOnUiThread(runnable: Runnable) {
        if (this is Activity) {
            runOnUiThread(runnable)
        } else {
            Handler(Looper.getMainLooper()).post(runnable)
        }
    }
}
