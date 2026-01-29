package com.example.imin_weight_plugin

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import com.imin.scalelibrary.ScaleManager
import com.imin.scalelibrary.ScaleResult

class IminWeightPlugin : FlutterPlugin {

    private lateinit var context: Context
    private var scaleManager: ScaleManager? = null

    private var eventSink: EventChannel.EventSink? = null
    private var isServiceConnected = false
    private var isReading = false

    private val handler = Handler(Looper.getMainLooper())

    // --------------------------------------------------
    // Plugin attached
    // --------------------------------------------------
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        EventChannel(binding.binaryMessenger, "imin_scale/weight")
            .setStreamHandler(object : EventChannel.StreamHandler {

                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    Log.d("IMIN_SCALE", "Flutter started listening")
                    connectScale()
                }

                override fun onCancel(arguments: Any?) {
                    Log.d("IMIN_SCALE", "Flutter stopped listening")
                    stopAndDisconnect()
                }
            })
    }

    // --------------------------------------------------
    // Connect scale service
    // --------------------------------------------------
    private fun connectScale() {
        scaleManager = ScaleManager.getInstance(context)

        scaleManager?.connectService(object :
            ScaleManager.ScaleServiceConnection {

            override fun onServiceConnected() {
                Log.d("IMIN_SCALE", "Scale service connected")
                isServiceConnected = true
                startReading()
            }

            override fun onServiceDisconnect() {
                Log.d("IMIN_SCALE", "Scale service disconnected")
                isServiceConnected = false
                isReading = false
            }
        })
    }

    // --------------------------------------------------
    // Start reading weight
    // --------------------------------------------------
    private fun startReading() {
        if (!isServiceConnected || isReading) return
        isReading = true

        scaleManager?.getData(object : ScaleResult() {

            override fun getResult(
                net: Int,
                tare: Int,
                isStable: Boolean
            ) {
                handler.post {
                    eventSink?.success(net)
                }
            }

            override fun getStatus(
                isLightWeight: Boolean,
                overload: Boolean,
                clearZeroErr: Boolean,
                calibrationErr: Boolean
            ) {}

            override fun getPrice(
                net: Int,
                tare: Int,
                unit: Int,
                unitPrice: String,
                totalPrice: String,
                isStable: Boolean,
                isLightWeight: Boolean
            ) {}

            override fun error(errorCode: Int) {
                Log.e("IMIN_SCALE", "SDK error: $errorCode")
            }
        })
    }

    // --------------------------------------------------
    // STOP AND FULLY DISCONNECT (CRITICAL)
    // --------------------------------------------------
    private fun stopAndDisconnect() {
        try {
            scaleManager?.cancelGetData()
        } catch (e: Exception) {
            Log.w("IMIN_SCALE", "cancelGetData error: ${e.message}")
        }

        try {
            scaleManager?.disconnectService()
        } catch (e: Exception) {
            Log.w("IMIN_SCALE", "disconnectService error: ${e.message}")
        }

        scaleManager = null
        eventSink = null
        isReading = false
        isServiceConnected = false
    }

    // --------------------------------------------------
    // Plugin detached
    // --------------------------------------------------
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        stopAndDisconnect()
    }
}
