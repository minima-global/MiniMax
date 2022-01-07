package com.minima.minimax.utils.extensions

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Looper
import com.minima.minimax.MainActivity
import com.minima.service.MinimaService
import com.minima.service.MinimaService.runInBackgroundWhenKilledKey
import com.minima.service.MinimaStuckToAppService
import io.flutter.plugin.common.MethodCall

fun MainActivity.startMinimaService(call: MethodCall) {
    // Stop any service first
    (getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager)
        .getRunningServices(Integer.MAX_VALUE)
        .forEach {
            val intent = Intent(this, it.javaClass)
            stopService(intent)
        }

    // Then start the right service
    Handler(Looper.getMainLooper()).postDelayed({
        val runInBackgroundEvenWhenKilled = call.argument("runInBackgroundEvenWhenKilled") ?: false
        val minimaServiceClass = if (runInBackgroundEvenWhenKilled) {
            MinimaService::class
        } else {
            MinimaStuckToAppService::class
        }

        val minimaIntent = Intent(this, minimaServiceClass.java).apply {
            putExtra(runInBackgroundWhenKilledKey, runInBackgroundEvenWhenKilled)
        }
        startForegroundService(minimaIntent)
        bindService(minimaIntent, this, Context.BIND_AUTO_CREATE)
    }, 2000)

}
