package com.example.imin_weight_plugin

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import com.imin.scalelibrary.ScaleManager
import com.imin.scalelibrary.ScaleResult
import java.util.Timer
import java.util.TimerTask

class IminWeightPlugin : FlutterPlugin {

    private lateinit var context: Context
    private lateinit var scaleManager: ScaleManager
    private var eventSink: EventChannel.EventSink? = null
    private var timer: Timer? = null

    //  1. Called when plugin is attached
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        EventChannel(binding.binaryMessenger, "imin_scale/weight")
            .setStreamHandler(object : EventChannel.StreamHandler {

                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    connectScale()
                }

                override fun onCancel(arguments: Any?) {
                    stopReading()
                }
            })
    }

    //  2. Connect scale service
    private fun connectScale() {
        scaleManager = ScaleManager.getInstance(context)

        scaleManager.connectService(object :
            ScaleManager.ScaleServiceConnection {

            override fun onServiceConnected() {
                Log.d("IMIN_SCALE", "Scale service connected")
                startReading()
            }

            override fun onServiceDisconnect() {
                Log.d("IMIN_SCALE", "Scale service disconnected")
            }
        })
    }

    //  3. Read weight periodically
    private fun startReading() {
        timer = Timer()
        timer?.scheduleAtFixedRate(object : TimerTask() {
            override fun run() {

                scaleManager.getData(object : ScaleResult() {

                    override fun getResult(net: Int, tare: Int, isStable: Boolean) {
                        if (isStable) {
                            Handler(Looper.getMainLooper()).post {
                                eventSink?.success(net)
                            }
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
                        Log.e("IMIN_SCALE", "error=$errorCode")
                    }
                })
            }
        }, 0, 400)
    }

    //  4. Stop reading
    private fun stopReading() {
        timer?.cancel()
        timer = null
        if (::scaleManager.isInitialized) {
            scaleManager.cancelGetData()
        }
        eventSink = null
    }

    //  5. Plugin detached (MUST be at class level)
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        stopReading()
    }
}
