package com.minima.minimax.utils.extensions

import android.content.Context
import android.content.Intent
import com.minima.minimax.MainActivity
import com.minima.service.MinimaService
import com.minima.service.MinimaService.runInBackgroundWhenKilledKey
import com.minima.service.MinimaStuckToAppService
import io.flutter.plugin.common.MethodCall

fun MainActivity.startMinimaService(call: MethodCall) {
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
}
