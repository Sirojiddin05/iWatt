import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var methodChannel: FlutterMethodChannel?
  private var eventChannel: FlutterEventChannel?
  private let linkStreamHandler = LinkStreamHandler()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDZzH71kY2Ap4o4_bvPa4JyBbYWp0pj8F0")
    let controller = window.rootViewController as! FlutterViewController
    methodChannel = FlutterMethodChannel(name: "https://app.i-watt.uz/AppRedirect/channel", binaryMessenger: controller.binaryMessenger)
    eventChannel = FlutterEventChannel(name: "https://app.i-watt.uz/AppRedirect/events", binaryMessenger: controller.binaryMessenger)
    methodChannel?.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) in
      guard call.method == "deeplink" else {
        result(FlutterMethodNotImplemented)
        return
      }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
   eventChannel?.setStreamHandler(linkStreamHandler)
   return linkStreamHandler.handleLink(url.absoluteString)
  }

  override func application(_ application: UIApplication,
                      continue userActivity: NSUserActivity,
                      restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
   // Get URL components from the incoming user activity.
   guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
       let incomingURL = userActivity.webpageURL,
       let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
       return false
   }
   eventChannel?.setStreamHandler(linkStreamHandler)
   return linkStreamHandler.handleLink(components.string ?? "")
  }
}

class LinkStreamHandler:NSObject, FlutterStreamHandler {

  var eventSink: FlutterEventSink?
  // links will be added to this queue until the sink is ready to process them
  var queuedLinks = [String]()
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    queuedLinks.forEach({ events($0) })
    queuedLinks.removeAll()
    return nil
  }
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    self.eventSink = nil
    return nil
  }
  func handleLink(_ link: String) -> Bool {
    guard let eventSink = eventSink else {
      queuedLinks.append(link)
      return false
    }
    eventSink(link)
    return true
  }
}

