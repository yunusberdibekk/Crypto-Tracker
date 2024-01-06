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
