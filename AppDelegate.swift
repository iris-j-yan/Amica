//
//  AppDelegate.swift
//  Tandem Health (iOS)
//
//  Created by Iris Yan on 8/8/23.
//

import UIKit
import SwiftUI
import Firebase
@main
struct AmicaHealth: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var fitbitAuthManager = FitbitAuthManager()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    fitbitAuthManager.handleFitbitCallback(url: url)
                }
                .environmentObject(fitbitAuthManager)
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Removed FirebaseApp.configure() from here
        return true
    }
    // ... other delegate methods
}

