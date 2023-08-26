package com.ausam.medibot
import android.content.Context
import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
import android.net.wifi.SupplicantState
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val CHANNEL = "MedibotChannel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "connectToWiFi") {
                print("Helko world")
                val ssid = call.argument<String>("ssid")
                val password = call.argument<String>("password")
                val isConnected = connectToWiFi(ssid, password)
                result.success(isConnected)
            } else {
                print("Helko world herei am")
                result.notImplemented()
            }
        }
    }
    @SuppressLint("HardwareIds")
    private fun connectToWiFi(ssid: String?, password: String?): String {
        if (ContextCompat.checkSelfPermission(context, Manifest.permission.CHANGE_WIFI_STATE) == PackageManager.PERMISSION_GRANTED) {

            val wifiManager = context.applicationContext?.getSystemService(Context.WIFI_SERVICE) as WifiManager

            if(wifiManager.isWifiEnabled){
                wifiManager.let {
                    val wifiConfig = WifiConfiguration().apply {
                        SSID = "\"$ssid\""
                        preSharedKey = "\"$password\""
                    }

                val networkId = wifiManager.addNetwork(wifiConfig)
                wifiManager.disconnect()
                wifiManager.enableNetwork(networkId, true)
                wifiManager.reconnect()
                    return wifiManager.connectionInfo.ipAddress.toString()
                }
            }else {
                return "false"
            }
        }else {
            ActivityCompat.requestPermissions(activity, arrayOf(Manifest.permission.CHANGE_WIFI_STATE), 101)
        }
        return "false"
    }
}