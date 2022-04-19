package global.org.minima.boot;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import global.org.minima.service.MinimaService;

public class BootReceiver extends BroadcastReceiver {
    
    @Override
    public void onReceive(Context context, Intent intent) {
        if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())
                || Intent.ACTION_USER_PRESENT.equals(intent.getAction())) {
            context.startForegroundService(new Intent(context, MinimaService.class));
        }
    }

}
