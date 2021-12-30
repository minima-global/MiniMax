package com.minima.minimax.utils.extensions

import android.content.Context
import android.content.Intent
import com.minima.minimax.MainActivity
import com.minima.service.MinimaService

fun MainActivity.startMinimaService() {
    val minimaIntent = Intent(this, MinimaService::class.java)
    startForegroundService(minimaIntent)
    bindService(minimaIntent, this, Context.BIND_AUTO_CREATE)
}