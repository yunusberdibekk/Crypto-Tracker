//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings

    private let coinDataService = CoinDataService() // TODO: -Bunu dışarıdan alabiliriz.
    private let marketDataService = MarketDataService() // TODO: -Bunu dışarıdan alabiliriz.
    private let portfolioDataService = PortfolioDataService() // TODO: -Singleton kullanılabilir.
    private var cancellables = Set<AnyCancellable>()

    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        /// Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)

        /// Updates fortfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)

        /// Updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }

    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }

    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
    }

    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins) // Sort işlemi direkt updatedCoins'in gösterdiği bellek adresinde yapılıyor.
        return updatedCoins
    }

    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter { coin -> Bool in
            coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }
    }

    /// inout ile parametre aldığın değişkene sonucu aktar.(pointer mantığı)
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sortOption {
        case .rank, .holdings:
            /// Sort işlemi direkt gelen dizi içinde yapılıyor.Yani dizinin kendi içi değişiyor.
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }

    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolioValue = portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +) // İlk değeri sıfır. Double arrayi içinde tüm elemanları topla.
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }

    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        /// will only sort by holdings or reversedHoldings if needed
        switch sortOption {
        case .holdings:
            coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            coins
        }
    }

    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
}

/*
 SwiftUI'da "debounce" terimi, genellikle kullanıcının bir giriş alanına yazdığı metni işlerken, her harf girişi sonrasında oluşan hızlı ve sürekli güncellemeleri kontrol etmek için kullanılır. Bu durumu kontrol etmek, gereksiz işlem yükünü azaltabilir ve uygulama performansını artırabilir.

 Debounce, genellikle kullanıcının yazma eylemi sırasında belirli bir süre boyunca hiç yeni giriş olmazsa bir işlemin tetiklenmesi anlamına gelir. Bu süre zarfında yeni bir giriş olmazsa, işlemin tetiklenmesi gecikir. Bu, özellikle arama kutuları gibi hızlı metin girişi yapılan yerlerde kullanışlı olabilir.
 */
