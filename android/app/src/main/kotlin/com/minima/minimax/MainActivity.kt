package com.minima.minimax

import androidx.annotation.NonNull
import com.minima.minimax.utils.extensions.ignoreBatteryOptimization
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, mainChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "ignoreBatteryOptimization" -> result.success(ignoreBatteryOptimization())
                else -> result.notImplemented()
            }
        }
    }
}

private const val mainChannel = "com.minima/main"