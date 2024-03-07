package me.relex.flutter.plugin.window_rounded_corners

import android.os.Build
import android.view.RoundedCorner
import androidx.core.view.OnApplyWindowInsetsListener
import androidx.core.view.ViewCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class WindowRoundedCornersPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var _corners: Map<String, Double>? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger, "me.relex.flutter.plugin.window_rounded_corners"
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getWindowCorners" -> {
                //Log.e(
                //    "RoundedCornerPlugin", "onMethodCall getWindowCorners  $_corners"
                //)
                val corners = _corners
                if (!corners.isNullOrEmpty()) {
                    result.success(corners);
                } else {
                    result.error("no data", null, null);
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        val density = binding.activity.resources.displayMetrics.density.toDouble()

        ViewCompat.setOnApplyWindowInsetsListener(
            binding.activity.window.decorView,
            OnApplyWindowInsetsListener { _, insetsCompat ->
                val insets = insetsCompat.toWindowInsets()
                if (insets != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    val tlRadius = insets.getRoundedCorner(RoundedCorner.POSITION_TOP_LEFT)?.radius
                        ?: 0
                    val trRadius = insets.getRoundedCorner(RoundedCorner.POSITION_TOP_RIGHT)?.radius
                        ?: 0
                    val brRadius = insets.getRoundedCorner(RoundedCorner.POSITION_BOTTOM_RIGHT)?.radius
                        ?: 0
                    val blRadius = insets.getRoundedCorner(RoundedCorner.POSITION_BOTTOM_LEFT)?.radius
                        ?: 0

                    val corners = buildMap {
                        this["tl"] = tlRadius / density
                        this["tr"] = trRadius / density
                        this["br"] = brRadius / density
                        this["bl"] = blRadius / density
                    }
                    _corners = corners
                    channel.invokeMethod("updateWindowCorners", corners)
                    //Log.e(
                    //    "RoundedCornerPlugin",
                    //    "OnApplyWindowInsetsListener corners = $corners"
                    //)
                }
                return@OnApplyWindowInsetsListener insetsCompat
            })
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }
}
