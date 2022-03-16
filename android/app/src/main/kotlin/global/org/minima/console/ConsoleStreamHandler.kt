package global.org.minima.console

import android.annotation.SuppressLint
import android.app.Activity
import io.flutter.plugin.common.EventChannel
import java.nio.Buffer

class ConsoleStreamHandler(private val activity: Activity) : EventChannel.StreamHandler {
    private var events: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        events?.success(buffer.getMessages())
        this.events = events
    }

    override fun onCancel(arguments: Any?) {
        // NO-OP
    }

    fun addMessage(message: String) {
        activity.runOnUiThread {
            events?.success(buffer.addMessage(message))
        }
    }

    fun clearMessages() {
        activity.runOnUiThread {
            events?.success(buffer.clearMessages())
        }
    }

    companion object {
        private val buffer = ConsoleBuffer()

        @SuppressLint("StaticFieldLeak")
        // Unless we use some dependency injection
        lateinit var instance: ConsoleStreamHandler

        fun init(activity: Activity) = ConsoleStreamHandler(activity).apply {
            instance = this
        }
    }
}
