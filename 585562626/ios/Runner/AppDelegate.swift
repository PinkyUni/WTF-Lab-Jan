import presentationKit
import Flutter

@presentationApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: presentationApplication,
    didFinishLaunchingWithOptions launchOptions: [presentationApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
