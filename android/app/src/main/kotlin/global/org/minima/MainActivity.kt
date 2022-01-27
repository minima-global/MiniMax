package global.org.minima

import android.content.ComponentName
import android.content.ServiceConnection
import android.os.IBinder
import com.jraska.console.Console
import global.org.minima.terminal.TerminalPlatformView
import global.org.minima.extensions.isIgnoringBatteryOptimizationModal
import global.org.minima.extensions.showIgnoreBatteryOptimizationModal
import global.org.minima.extensions.runCommandFromArguments
import global.org.minima.extensions.startMinimaService
import global.org.minima.service.MinimaService.MyBinder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

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
                "ignoreBatteryOptimization" -> result.success(showIgnoreBatteryOptimizationModal())
                "isIgnoringBatteryOptimization" -> result.success(isIgnoringBatteryOptimizationModal())
                "startMinimaService" -> {
                    startMinimaService(call)
                    result.success(true)
                }
                "runCommand" -> {

                    minima?.let {
                        Thread {
                            result.success(it.runCommandFromArguments(call))
                        }.start()
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