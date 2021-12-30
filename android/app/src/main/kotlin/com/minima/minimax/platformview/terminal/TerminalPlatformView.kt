package com.minima.minimax.platformview.terminal

import android.content.Context
import android.view.View
import android.widget.TextView
import com.jraska.console.Console
import com.minima.minimax.R
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class TerminalPlatformView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val console = Console(context).apply {
        findViewById<TextView>(R.id.console_text).textSize = 10f
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