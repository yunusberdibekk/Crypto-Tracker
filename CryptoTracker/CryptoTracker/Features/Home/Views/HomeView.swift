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
    @State private var showPortfolioView: Bool = false

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PorfolioView()
                        .environmentObject(homeViewModel)
                })
            VStack(content: {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
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
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
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
            ForEach($homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(
                        .init(top: 10,
                              leading: 0,
                              bottom: 10,
                              trailing: 10))
            }
        }
        .listStyle(.plain)
    }

    private var portfolioCoinsList: some View {
        List {
            ForEach($homeViewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(
                        .init(top: 10,
                              leading: 0,
                              bottom: 10,
                              trailing: 10))
            }
        }
        .listStyle(.plain)
    }

    private var columnTitles: some View {
        HStack(content: {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .rank ||
                            homeViewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(.degrees(
                        homeViewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((homeViewModel.sortOption == .holdings ||
                                homeViewModel.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(.degrees(
                            homeViewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        homeViewModel.sortOption = homeViewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .price ||
                            homeViewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(.degrees(
                        homeViewModel.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    homeViewModel.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(.degrees(homeViewModel.isLoading ? 360 : 0), anchor: .center)
            .sensoryFeedback(.start, trigger: homeViewModel.isLoading)
        })
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
