//
//  ContentView.swift
//  Shared
//
//  Created by Iris Yan on 8/3/23.
////
///
/////
//import SwiftUI
//import FirebaseCore
//import Firebase
//import FirebaseFirestore
//
//
//class FitbitAuthManager: ObservableObject {
//    func handleFitbitCallback(url: URL) {
//        // Handle the URL here
//        if url.scheme == "amica-health-auth" {
//            // Extract the authorization code, exchange for an access token, etc.
//        }
//    }
//}
//
//@main
//FirebaseApp.configure()
//struct AmicaHealth: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject var fitbitAuthManager = FitbitAuthManager()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .onOpenURL { url in
//                    fitbitAuthManager.handleFitbitCallback(url: url)
//                }
//                .environmentObject(fitbitAuthManager)
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var isAuthenticated: Bool = false
//    @State private var hasCompletedProfile: Bool = false
//    @State private var hasCompletedHealthDataAccess: Bool = false
//
//    var body: some View {
//        if !isAuthenticated {
//            AuthenticationView(isAuthenticated: $isAuthenticated)
//        } else if !hasCompletedProfile {
//            UserProfileView(hasCompletedProfile: $hasCompletedProfile, hasCompletedHealthDataAccess: $hasCompletedHealthDataAccess)
//        } else if !hasCompletedHealthDataAccess {
//            HealthDataAccessView(hasCompletedHealthDataAccess: $hasCompletedHealthDataAccess)
//        } else {
//            MainTabView()
//        }
//    }
//}
//
import SwiftUI
import FirebaseCore
import Firebase
import FirebaseFirestore

class FitbitAuthManager: ObservableObject {
    func handleFitbitCallback(url: URL) {
        if url.scheme == "amica-health-auth" {
            // Handle the URL callback
        }
    }
}

struct ContentView: View {
    @State private var isAuthenticated: Bool = false
    @State private var hasCompletedProfile: Bool = false
    @State private var hasCompletedHealthDataAccess: Bool = false

    var body: some View {
        if !isAuthenticated {
            AuthenticationView(isAuthenticated: $isAuthenticated)
        } else if !hasCompletedProfile {
            UserProfileView(hasCompletedProfile: $hasCompletedProfile, hasCompletedHealthDataAccess: $hasCompletedHealthDataAccess)
        } else if !hasCompletedHealthDataAccess {
            HealthDataAccessView(hasCompletedHealthDataAccess: $hasCompletedHealthDataAccess)
        } else {
            MainTabView()
        }
    }
}
