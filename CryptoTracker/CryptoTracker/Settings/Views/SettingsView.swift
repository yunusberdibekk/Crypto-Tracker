//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import SwiftUI

struct SettingsView: View {
    let defaultURL = URL(string: "https://www.google.com")!
    let githubURL = URL(string: "https://github.com/yunusberdibekk/Crypto-Tracker")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.linkedin.com/in/yunusberdibekk/")!

    var body: some View {
        NavigationStack {
            ZStack(content: {
                Color.theme.background.ignoresSafeArea()
                List {
                    viewAppCodeSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            })

            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            })
        }
    }
}

#Preview {
    SettingsView()
}

private struct SectionView<Content: View>: View {
    let header: String
    let image: ImageResource
    let description: String
    var content: Content

    init(header: String, image: ImageResource, description: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.image = image
        self.description = description
        self.content = content()
    }

    var body: some View {
        Section {
            VStack(alignment: .leading, content: {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(description)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding(.vertical)
            content
        } header: {
            Text(header)
        }
    }
}

extension SettingsView {
    private var viewAppCodeSection: some View {
        SectionView(header: "Crypto Tracker", image: .logo, description: "This app uses MVVM Architecture, Combine and CoreData.") {
            SectionRowView(destination: githubURL, imageName: "hammer.fill", backgroundColor: .pink, text: "View App Code")
        }
    }

    private var coinGeckoSection: some View {
        SectionView(header: "CoinGecko", image: .coingecko, description: "The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.") {
            SectionRowView(destination: coingeckoURL, imageName: "list.clipboard", backgroundColor: .orange, text: "Visit CoinGecko")
        }
    }

    private var developerSection: some View {
        SectionView(header: "Developer", image: .developer, description: "This app was developed by Yunus Emre Berdibek. It uses SwiftUI and is written %100 in Swift. The project benefits from multi-threading, publishers-subscribers and data persistance.") {
            SectionRowView(destination: personalURL, imageName: "globe", backgroundColor: .green, text: "Visit LinkedIn")
        }
    }

    private var applicationSection: some View {
        Section {
            SectionRowView(destination: defaultURL, imageName: "doc", backgroundColor: .red, text: "Terms of Service")
            SectionRowView(destination: defaultURL, imageName: "lock", backgroundColor: .yellow, text: "Pricacy Compacy")
            SectionRowView(destination: defaultURL, imageName: "paperplane", backgroundColor: .mint, text: "Contact Us")
            SectionRowView(destination: defaultURL, imageName: "globe", backgroundColor: .purple, text: "Learn More")
        } header: {
            Text("Application")
        }
    }
}
