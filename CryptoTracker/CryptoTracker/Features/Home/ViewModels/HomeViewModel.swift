//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        dataService.$allCoins.sink { [weak self] returnedCoins in
            self?.allCoins = returnedCoins
        }
        .store(in: &cancellables)
    }
}