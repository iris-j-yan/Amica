//
//  MainTabView.swift
//  Proto
//
//  Created by Iris Yan on 8/3/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
          RecommendationView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            ChatView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}
