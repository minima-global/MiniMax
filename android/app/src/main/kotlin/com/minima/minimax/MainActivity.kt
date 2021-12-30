package com.minima.minimax

import android.content.ComponentName
import android.content.ServiceConnection
import android.os.IBinder
import com.jraska.console.Console
import com.minima.minimax.platformview.terminal.TerminalPlatformView
import com.minima.minimax.utils.extensions.ignoreBatteryOptimization
import com.minima.minimax.utils.extensions.runCommandFromArguments
import com.minima.minimax.utils.extensions.startMinimaService
import com.minima.service.MinimaService.MyBinder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.minima.Minima

class MainActivity : FlutterActivity(), ServiceConnection {
    private var minima: Minima? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        configureMethodHandler(flutterEngine)
        configurePlatformViews(flutterEngine)
    }

    private fun configurePlatformViews(flutterEngine: FlutterEngine) {
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(TerminalPlatformView.viewTypeId, TerminalPlatformView.factory)
    }

    private fun configureMethodHandler(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, mainChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "ignoreBatteryOptimization" -> result.success(ignoreBatteryOptimization())
                "startMinimaService" -> {
                    startMinimaService()
                    result.success(true)
                }
                "runCommand" -> {
                    minima?.let {
                        result.success(it.runCommandFromArguments(call))
                    }
                        ?: result.error("MINIMA_NOT_STARTED", "Minima not started", null)
                }
                "clearTerminal" -> Console.clear()
                else -> result.notImplemented()
            }
        }
    }

    override fun onServiceConnected(componentName: ComponentName?, iBinder: IBinder) {
        val binder = iBinder as MyBinder
        minima = binder.service.minima
    }

    override fun onServiceDisconnected(componentName: ComponentName?) {
        minima = null
    }
}

private const val mainChannel = "com.minima/main"