package com.flutter.facebook.platform

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.os.bundleOf
import com.facebook.BuildConfig
import com.facebook.FacebookSdk
import com.facebook.FacebookSdk.InitializeCallback
import com.facebook.appevents.AppEventsLogger
import com.google.gson.Gson
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.math.BigDecimal
import java.util.Currency

/** FbInitPlugin */
class FacebookPlatformPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    val gson = Gson()

    var applicationContext: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "PlatformFacebookPlugin")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "isInitialized" -> {
                log("isInitialized")
                val value = FacebookSdk.isInitialized().toString()
                result.success(value)
                log("isInitialized $value")
            }

            "sdkInit" -> {
                log("sdkInit")
                val arguments = call.arguments as Map<*, *>
                val applicationId = arguments["applicationId"] as String
                val clientToken = arguments["clientToken"] as String
                FacebookSdk.setApplicationId(applicationId)
                FacebookSdk.setClientToken(clientToken)
                applicationContext?.let {
                    FacebookSdk.sdkInitialize(it) {
                        result.success("sdkInit success")
                        log("sdkInit success")
                    }
                }
            }

            "event" -> {

                if (!FacebookSdk.isInitialized()) {
                    result.error("-1", "Facebook Sdk not initialized", "Facebook Sdk not initialized")
                    return
                }

                val arguments = call.arguments as Map<*, *>
                log("event arguments ${gson.toJson(arguments)}")
                val eventName = arguments["eventName"] as String
                val logger = applicationContext?.let { AppEventsLogger.newLogger(it) }
                logger?.logEvent(eventName, bundleOf().apply {
                    val parameters = arguments["parameters"]
                    log("event parameters ${gson.toJson(parameters)}")
                    if (parameters is Map<*, *>) {
                        parameters.entries.forEach {
                            if (it.key is String && it.value is String) {
                                putString(it.key?.toString() ?: "", it.value?.toString() ?: "")
                            }
                            if (it.key is String && it.value is Double) {
                                putDouble(it.key?.toString() ?: "", it.value as Double)
                            }
                            if (it.key is String && it.value is Long) {
                                putLong(it.key?.toString() ?: "", it.value as Long)
                            }
                            if (it.key is String && it.value is Float) {
                                putFloat(it.key?.toString() ?: "", it.value as Float)
                            }
                            if (it.key is String && it.value is Int) {
                                putInt(it.key?.toString() ?: "", it.value as Int)
                            }

                        }
                    }

                })
                result.success("event success")
                log("event success")
            }

            "purchase" -> {
                if (!FacebookSdk.isInitialized()) {
                    result.error("-1", "Facebook Sdk not initialized", "Facebook Sdk not initialized")
                    return
                }

                val arguments = call.arguments as Map<*, *>
                log("purchase arguments ${gson.toJson(arguments)}")

                val purchaseAmount = arguments["purchaseAmount"] as Double
                val currency = arguments["currency"] as String
                val logger = applicationContext?.let { AppEventsLogger.newLogger(it) }
                logger?.logPurchase(BigDecimal(purchaseAmount), Currency.getInstance(currency), bundleOf().apply {
                    val parameters = arguments["parameters"]
                    log("purchase parameters ${gson.toJson(arguments)}")
                    if (parameters is Map<*, *>) {
                        parameters.entries.forEach {
                            if (it.key is String && it.value is String) {
                                putString(it.key?.toString() ?: "", it.value?.toString() ?: "")
                            }
                            if (it.key is String && it.value is Double) {
                                putDouble(it.key?.toString() ?: "", it.value as Double)
                            }
                            if (it.key is String && it.value is Long) {
                                putLong(it.key?.toString() ?: "", it.value as Long)
                            }
                            if (it.key is String && it.value is Float) {
                                putFloat(it.key?.toString() ?: "", it.value as Float)
                            }
                            if (it.key is String && it.value is Int) {
                                putInt(it.key?.toString() ?: "", it.value as Int)
                            }

                        }
                    }

                })
                result.success("purchase success")
                log("purchase success")

            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun log(s: Any) {
        if (BuildConfig.DEBUG) {
            Log.d(this::class.java.name, s.toString())
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

}

