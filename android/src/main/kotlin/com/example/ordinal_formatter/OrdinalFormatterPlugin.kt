package com.example.ordinal_formatter

import android.icu.text.MessageFormat
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.Locale

/** OrdinalFormatterPlugin */
class OrdinalFormatterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ordinal_formatter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method != "format") {
      result.notImplemented()
      return
    }

    val number = call.argument<Any>("number")?.let { it.toString().toIntOrNull() }
    ?: run { 
      result.error("INVALID_NUMBER", "invalid number format", null)
      return
    }

    val locale = call.argument<Any>("locale_code")?.let { 
      // BCP 47 standard uses "-" instead of "_"
      val localCode = it.toString().replace("_", "-")
      Locale.forLanguageTag(localCode)
    } ?: Locale.getDefault()

    if (Locale.getAvailableLocales().contains(locale)) {
      result.success(format(number, locale))
    } else {
      result.error("INVALID_LOCALE", "invalid locale identifier: ${call.argument<String>("locale_code")}", null)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun format(number: Int, locale: Locale): String {
    return MessageFormat("{0, ordinal}", locale).format(arrayOf(number.toInt()))
  }
}
