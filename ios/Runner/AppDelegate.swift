import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyAj8s5HSB-D5pnmtvr1Eb_bwsn6OEJL3JQ")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
