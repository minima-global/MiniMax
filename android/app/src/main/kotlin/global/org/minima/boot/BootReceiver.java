package global.org.minima.boot;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import global.org.minima.service.ServiceStarterJobService;

public class BootReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        System.out.println("RAFA MINIMA RECEIVER " + intent.getAction());
        //MinimaLogger.log("MINIMA RECEIVER "+intent.getAction());

        if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())
                || Intent.ACTION_USER_PRESENT.equals(intent.getAction())) {
            System.out.println("RAFA MINIMA LANDED");
            ServiceStarterJobService.enqueueWork(context, new Intent());
        }
    }

}
