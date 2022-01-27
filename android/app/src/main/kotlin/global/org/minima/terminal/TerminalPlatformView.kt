package global.org.minima.terminal

import android.content.Context
import android.view.View
import android.widget.ScrollView
import android.widget.TextView
import com.jraska.console.Console
import global.org.minima.R
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class TerminalPlatformView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val console = Console(context).apply {
        findViewById<TextView>(R.id.console_text).apply {
            textSize = 12f
            setTextColor(context.getColor(R.color.coreGrey100))
        }
        findViewById<ScrollView>(R.id.console_scroll_view).apply {
            setBackgroundResource(R.color.coreBlackDarkBlack)
            setPadding(0, 20, 0, 0)
            clipToPadding = false
        }
    }

    override fun getView(): View {
        return console
    }

    override fun dispose() {}

    companion object {
        val factory = object: PlatformViewFactory(StandardMessageCodec.INSTANCE) {
            override fun create(context: Context, viewId: Int, args: Any?): TerminalPlatformView {
                val creationParams = args as Map<String?, Any?>?
                return TerminalPlatformView(context, viewId, creationParams)
            }
        }

        const val viewTypeId = "TerminalPlatformView"
    }
}