//
//  SwiftfulFirebasePackagesExampleApp.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/18/24.
//

import SwiftUI
import SwiftfulAuthenticating
import SwiftfulAuthenticatingFirebase
import SwiftfulLogging
import Firebase

@main
struct SwiftfulFirebasePackagesExampleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(AuthManager(
                    service: FirebaseAuthService(),
                    logger: LogManager(services: [ConsoleService(printParameters: false)])
                ))
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        Auth.auth().setAPNSToken(deviceToken, type: .prod)
//    }
//
//    func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if Auth.auth().canHandleNotification(notification) {
//            completionHandler(.noData)
//            return
//        }
//    }
//    
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        if Auth.auth().canHandle(url) {
//            return true
//        }
//        return false
//    }
}
