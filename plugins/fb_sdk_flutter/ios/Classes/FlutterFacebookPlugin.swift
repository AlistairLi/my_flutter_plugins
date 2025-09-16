import AppTrackingTransparency
import FBSDKCoreKit
import Flutter
import UIKit

public class FacebookPlatformPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "PlatformFacebookPlugin", binaryMessenger: registrar.messenger())
        let instance: FacebookPlatformPlugin = FacebookPlatformPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "sdkInit":
            let params = call.arguments as? [String: Any] ?? [:]
            print("sdkInit params = \(params)")
            Settings.shared.appID = params["applicationId"] as? String ?? ""
            Settings.shared.isAutoLogAppEventsEnabled = true
            Settings.shared.clientToken = params["clientToken"] as? String ?? ""
            let launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil  // 如果没有特殊的启动参数，可以传 nil
            ApplicationDelegate.shared.application(
                UIApplication.shared, didFinishLaunchingWithOptions: launchOptions)
            AppEvents.shared.activateApp()
            result("true")
        case "event":
            let params = call.arguments as? [String: Any] ?? [:]
            var appEventsDic: [AppEvents.ParameterName: Any] = [:]
            for (key, valeu) in params["parameters"] as? [String: Any] ?? [:] {
                appEventsDic[.init(key)] = valeu
            }
            AppEvents.shared.logEvent(
                AppEvents.Name(rawValue: params["eventName"] as? String ?? ""),
                parameters: appEventsDic)
            result("true")
        case "purchase":
            let params = call.arguments as? [String: Any] ?? [:]
            let purchaseAmount = params["purchaseAmount"] as? Double ?? 0
            let currency = params["currency"] as? String ?? "USD"
            var appEventsDic: [AppEvents.ParameterName: Any] = [:]
            for (key, value) in params["parameters"] as? [String: Any] ?? [:] {
                appEventsDic[.init(key)] = value
            }
            // debugPrint(
            //     "eventName = purchase, amount = \(purchaseAmount), currency = \(currency), parameters = \(appEventsDic)"
            // )
            AppEvents.shared.logPurchase(
                amount: purchaseAmount, currency: currency, parameters: appEventsDic)
            result("true")
        default:
            result(FlutterMethodNotImplemented)
        }
    }

}
