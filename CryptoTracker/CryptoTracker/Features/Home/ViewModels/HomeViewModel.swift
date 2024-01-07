//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = [
        .statistic1,
        .statistic2,
        .statistic3
    ]

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    @Published var searchText: String = ""

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        /// Update allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
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
}

/*
 SwiftUI'da "debounce" terimi, genellikle kullanıcının bir giriş alanına yazdığı metni işlerken, her harf girişi sonrasında oluşan hızlı ve sürekli güncellemeleri kontrol etmek için kullanılır. Bu durumu kontrol etmek, gereksiz işlem yükünü azaltabilir ve uygulama performansını artırabilir.

 Debounce, genellikle kullanıcının yazma eylemi sırasında belirli bir süre boyunca hiç yeni giriş olmazsa bir işlemin tetiklenmesi anlamına gelir. Bu süre zarfında yeni bir giriş olmazsa, işlemin tetiklenmesi gecikir. Bu, özellikle arama kutuları gibi hızlı metin girişi yapılan yerlerde kullanışlı olabilir.
 */
