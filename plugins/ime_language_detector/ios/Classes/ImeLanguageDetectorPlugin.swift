import Flutter
import UIKit

public class ImeLanguageDetectorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ime_language_detector", binaryMessenger: registrar.messenger())
    let instance = ImeLanguageDetectorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getImeLanguages":
      let languages = getImeLanguage()
      result([languages])
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getImeLanguage() -> String {
    // 创建一个临时输入框
    let textField = UITextField()
    UIApplication.shared.windows.first?.addSubview(textField)
    textField.becomeFirstResponder()

    // 等待系统分配 inputMode（必须在主线程）
    let lang = textField.textInputMode?.primaryLanguage ?? ""

    // 清理
    textField.resignFirstResponder()
    textField.removeFromSuperview()

    return lang
  }

  // 获取软键盘语言列表的第一个语言
//   private func getImeLanguage() -> String {
//       if let inputMode = UITextInputMode.activeInputModes.first,
//          let lang = inputMode.primaryLanguage {
//           return lang
//       }
//       return ""
//   }

}
