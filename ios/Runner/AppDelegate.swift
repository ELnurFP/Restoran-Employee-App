import UIKit
import FirebaseCore
import Flutter
import GoogleMaps  
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyA7vzVrs6OjPP09LFACbnHpKs5FK91QGQg")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
