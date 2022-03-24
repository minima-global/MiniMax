package global.org.minima

import android.content.ComponentName
import android.content.ServiceConnection
import android.os.Bundle
import android.os.IBinder
import global.org.minima.console.ConsoleStreamHandler
import global.org.minima.extensions.isIgnoringBatteryOptimizationModal
import global.org.minima.extensions.runCommandFromArguments
import global.org.minima.extensions.showIgnoreBatteryOptimizationModal
import global.org.minima.extensions.startMinimaService
import global.org.minima.service.MinimaService.MyBinder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import org.minima.Minima

class MainActivity : FlutterActivity(), ServiceConnection {
    private var minima: Minima? = null

    internal var shouldUnbind = false

    override fun onCreate(savedInstanceState: Bundle?) {
        ConsoleStreamHandler.init(this)
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        configureMethodHandler(flutterEngine)
        configureEventChannel(flutterEngine)
    }

    private fun configureEventChannel(flutterEngine: FlutterEngine) {
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, mainEventChannel)
            .setStreamHandler(ConsoleStreamHandler.instance)
    }

    private fun configureMethodHandler(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, mainPlatformChannel).setMethodCallHandler { call, result ->
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
                "clearTerminal" -> {
                    ConsoleStreamHandler.instance.clearMessages()
                    result.success(true)
                }
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

    override fun onDestroy() {
        super.onDestroy()
        if (shouldUnbind) {
            unbindService(this)
            shouldUnbind = false
        }
    }
}

private const val mainPlatformChannel = "com.minima/main"
private const val mainEventChannel = "com.minima/events"