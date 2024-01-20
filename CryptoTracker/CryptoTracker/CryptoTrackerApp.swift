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
    @State private var showLauchView: Bool = true

    init() {
        // Navigation title foreground color değiştirme.
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.clear
    }

    var body: some Scene {
        WindowGroup {
            ZStack(content: {
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden, for: .automatic)
                }
                .environmentObject(homeViewModel)
                ZStack(content: {
                    if showLauchView {
                        LaunchView(showLaunchView: $showLauchView)
                            .transition(.move(edge: .leading))
                    }
                })
                .zIndex(2.0)
            })
        }
    }
}
