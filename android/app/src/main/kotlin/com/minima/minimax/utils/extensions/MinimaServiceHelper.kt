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
    val runInBackgroundEvenWhenKilled = call.argument("runInBackgroundEvenWhenKilled") ?: false
    val force = call.argument("force") ?: false
    val minimaServiceClass = if (runInBackgroundEvenWhenKilled) {
        MinimaService::class
    } else {
        MinimaStuckToAppService::class
    }

    val anyService: () -> Boolean = {
        (getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager)
            .getRunningServices(Integer.MAX_VALUE)
            .any {
                return@any it.javaClass == minimaServiceClass.java
            }
    }

    if (anyService() && !force) {
        return
    }

    (getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager)
        .getRunningServices(Integer.MAX_VALUE)
        .filter {
            listOf(
                MinimaService::class.simpleName,
                MinimaStuckToAppService::class.simpleName
            ).contains(it.javaClass.simpleName)
        }
        .forEach {
            val intent = Intent(this, it.javaClass)
            stopService(intent)
        }

    Handler(Looper.getMainLooper()).postDelayed({
        val minimaIntent = Intent(this, minimaServiceClass.java).apply {
            putExtra(runInBackgroundWhenKilledKey, runInBackgroundEvenWhenKilled)
        }
        startForegroundService(minimaIntent)
        bindService(minimaIntent, this, Context.BIND_AUTO_CREATE)
    }, 2000)
}
