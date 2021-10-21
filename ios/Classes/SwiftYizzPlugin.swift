import Flutter
import UIKit

public class SwiftYizzPlugin: NSObject, FlutterPlugin {
    
//    var navigationController: UINavigationController?
//    var window: UIWindow?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "yizz_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftYizzPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getPlatformVersion"{
        result("iOS 88888888" + UIDevice.current.systemVersion)
    }else if call.method == "testSize"{
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        let vc = DDDViewController()
        let navigationController = UINavigationController.init(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        rootViewController?.present(navigationController, animated: true, completion: nil)
    }
  }
}
