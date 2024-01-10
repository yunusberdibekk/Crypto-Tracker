//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var homeViewModel = HomeViewModel()

    init() {
        // Navigation title foreground color değiştirme.
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .automatic)
            }
            .environmentObject(homeViewModel)
        }
    }
}
