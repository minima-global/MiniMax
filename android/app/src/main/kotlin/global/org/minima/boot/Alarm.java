package global.org.minima.boot;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import global.org.minima.service.MinimaService;

public class Alarm extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        context.startForegroundService(new Intent(context, MinimaService.class));
    }

}
