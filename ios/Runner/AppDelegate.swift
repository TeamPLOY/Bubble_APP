import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // APNs 등록
    UIApplication.shared.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
    print("Device Token: \(token)")
    
    // 서버에 토큰 전송
    sendDeviceTokenToServer(token: token)
  }

  // APNs 등록 실패 시 호출
  override func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    print("Failed to register for remote notifications: \(error)")
  }

  private func sendDeviceTokenToServer(token: String) {
    // 서버로 토큰 전송 로직 작성 (예: HTTP 요청)
    print("Sending device token to server: \(token)")
  }
}