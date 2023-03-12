import Flutter
import UIKit

public class OrdinalFormatterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ordinal_formatter", binaryMessenger: registrar.messenger())
    let instance = OrdinalFormatterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "format" else {
      result(FlutterMethodNotImplemented)
      return
    }

    guard let arguments = call.arguments as? [String: Any] else {
      result(FlutterError(code: "MISSING_ARGUMENT", message: "arguments are required", details: nil))
      return
    }

    guard let number = arguments["number"] as? Int else {
      result(FlutterError(code: "INVALID_NUMBER", message: "invalid number format", details: nil))
      return
    }

    guard let localeCode = arguments["locale_code"] as? String, !(localeCode is NSNull) else {
      result(format(number: number))
      return
    }

    // convert to legacy language format if needed
    let identifier = localeCode.replacingOccurrences(of: "-", with: "_")

    if Locale.availableIdentifiers.contains(identifier) {
      result(format(number: number, locale: Locale(identifier: identifier)))
    } else {
      let localeCode = arguments["locale_code"] as! String
      result(FlutterError(code: "INVALID_LOCALE", message: "invalid locale identifier: \(localeCode)", details: nil))
    }
  }

  private func format(number: Int, locale: Locale = Locale.current) -> String? {
    let formatter = NumberFormatter()
    formatter.locale = locale
    formatter.numberStyle = .ordinal
    return formatter.string(from: NSNumber(value: number))
  }
}
