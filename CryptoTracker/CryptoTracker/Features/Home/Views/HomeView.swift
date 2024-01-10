//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack(content: {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio) // Transition gelecek.
                SearchBarView(searchText: $homeViewModel.searchText)
                columnTitles
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                } else {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            })
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden, for: .automatic)
            .preferredColorScheme(.dark)
    }
    .environmentObject(HomeViewModel())
}

extension HomeView {
    private var homeHeader: some View {
        HStack(content: {
            CircleButtonView(iconName: showPortfolio ?
                "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ?
                "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(
                    showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        })
        .padding(.horizontal)
    }

    private var allCoinsList: some View {
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10,
                                         leading: 0,
                                         bottom: 10,
                                         trailing: 10))
            }
        }
        .listStyle(.plain)
    }

    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10,
                                         leading: 0,
                                         bottom: 10,
                                         trailing: 10))
            }
        }
        .listStyle(.plain)
    }

    private var columnTitles: some View {
        HStack(content: {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        })
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
