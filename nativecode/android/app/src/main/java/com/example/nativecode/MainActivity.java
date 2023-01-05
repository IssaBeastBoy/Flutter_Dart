package com.example.nativecode;

import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import android.content.Intent;
import android.content.Context;
import android.content.ContentProvider;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.content.BroadcastReceiver;
import 	android.content.IntentFilter;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "battery.life/get";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                    (call, result) -> {            
                if(call.method.equals("getBatteryLevel")){
                    int batteryLevel = getBatteryLevel();
                    if(batteryLevel != -1){
                        result.success(batteryLevel);
                    }
                    else{
                        result.error("Unavailable", "Could not fetch battery live.", null);
                    }
                }
                else{
                    result.noImplemented();
                }
                }
        );
   }

//     @Override
//   protected void onCreate(Bundle savedInstanceState) {
//     super.onCreate(savedInstanceState);
//     GeneratedPluginRegistrant.registerWith(this);

//     new MethodChannel(getFlutterView(), "battery.life/get").setMethodCallHandler(
//         new MethodCallHandler(){
//             @Override
//             public void onMethodCall(MethodCall call, Result result){
//                 if(call.method.equals("getBatteryLevel")){
//                     int batteryLevel = getBatteryLevel();
//                     if(batteryLevel != -1){
//                         result.success(batteryLevel);
//                     }
//                     else{
//                         result.error("Unavailable", "Could not fetch battery live.", null);
//                     }
//                 }
//                 else{
//                     result.noImplemented();
//                 }
//             }
//         }
//     );
//   } 

  private int getBatteryLevel(){
    int batteryLevel = -1;
    if(VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP){
        BatteryManager batteryManager = requireContext().getSystemService(BATTERY_SERVICE);
        batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);

    }else{
        IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        Intent batteryStatus = requireContext().registerReceiver(null, ifilter);
        batteryLevel = (batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 ) / batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }
  return batteryLevel;

}
}
