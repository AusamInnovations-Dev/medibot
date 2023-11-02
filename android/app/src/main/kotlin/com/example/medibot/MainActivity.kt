package com.ausam.medibot

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager
import android.net.wifi.WifiInfo
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.net.InetAddress
import java.net.UnknownHostException
import java.nio.ByteOrder
import java.math.BigInteger
import android.net.wifi.WifiNetworkSuggestion
import android.net.wifi.WifiNetworkSpecifier
import android.widget.Toast
import android.content.Intent
import android.content.IntentFilter
import android.content.BroadcastReceiver


class MainActivity : FlutterActivity() {

    private val CHANNEL = "MedibotChannel"
    private val PERMISSIONS_REQUEST_CODE = 123

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "connectToWifi" -> {
                    val ssid = call.argument<String>("ssid")
                    val password = call.argument<String>("password")
                    connectToWifi(ssid , password)
                    result.success("Wifi-------------------")
                }
                "getIpAddress" -> {
                    val ipAddress = getIpAddress()
                    result.success(ipAddress)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun connectToWifi(ssid: String?, password: String?):String {
        val wifiManager = context.getSystemService(Context.WIFI_SERVICE) as WifiManager

            val wifiConfiguration = WifiConfiguration()
            wifiConfiguration.SSID = ssid!!
            wifiConfiguration.preSharedKey = password!!

            val networkId = wifiManager.addNetwork(wifiConfiguration)
            if (networkId == -1) {
                return "Failed to add Wi-Fi configuration."
            }

            val wifiInfo = wifiManager.connectionInfo
            if (wifiInfo.networkId != networkId) {
                wifiManager.disconnect()
                wifiManager.enableNetwork(networkId, true)
            }

            while (true) {
                val newWifiInfo = wifiManager.connectionInfo
                // if (newWifiInfo.supplicantState == WifiInfo.SupplicantState.COMPLETED) {
                //     break
                // }

                Thread.sleep(100)
            }

            return wifiInfo.ipAddress.toString()
    }

    private fun getIpAddress(): String {
        val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        val ipAddress = wifiManager!!.connectionInfo.ipAddress

        // Convert little-endian to big-endian if needed
        val ipInt = if (ByteOrder.nativeOrder().equals(ByteOrder.LITTLE_ENDIAN)) {
            Integer.reverseBytes(ipAddress)
        } else {
            ipAddress
        }

        val ipByteArray = BigInteger.valueOf(ipInt.toLong()).toByteArray()

        return try {
            InetAddress.getByAddress(ipByteArray).hostAddress
        } catch (ex: UnknownHostException) {
            Log.e("WIFIIP", "Unable to get host address.")
            ""
        }
    }

    private fun showToast(s: String) {
        Toast.makeText(applicationContext, s, Toast.LENGTH_LONG).show()
    }
}