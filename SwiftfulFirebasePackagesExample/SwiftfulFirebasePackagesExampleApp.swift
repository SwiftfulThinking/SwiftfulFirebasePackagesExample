//
//  SwiftfulFirebasePackagesExampleApp.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/18/24.
//

import SwiftUI
import SwiftfulFirebaseAuth
import Firebase

@main
struct SwiftfulFirebasePackagesExampleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.auth, AuthManager(configuration: .firebase))
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

}
