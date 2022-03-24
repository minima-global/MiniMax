package global.org.minima.extensions

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.net.Uri

import android.os.PowerManager
import android.provider.Settings

/**
 * @return if the request has been triggered
 */
@SuppressLint("BatteryLife")
fun Context.showIgnoreBatteryOptimizationModal(): Boolean {
    val ignoringBatteryOptimizations = (getSystemService(Context.POWER_SERVICE) as? PowerManager)
        ?.isIgnoringBatteryOptimizations(packageName) == true

    if (!ignoringBatteryOptimizations) {
        startActivity(
            Intent().apply {
                action = Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS
                data = Uri.parse("package:$packageName")
            }
        )
    }

    return !ignoringBatteryOptimizations
}

@SuppressLint("BatteryLife")
fun Context.isIgnoringBatteryOptimizationModal(): Boolean {
    return (getSystemService(Context.POWER_SERVICE) as? PowerManager)
        ?.isIgnoringBatteryOptimizations(packageName) == true
}