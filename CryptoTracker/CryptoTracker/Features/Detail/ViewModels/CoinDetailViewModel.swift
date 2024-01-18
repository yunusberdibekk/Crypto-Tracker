//
//  CoinDetailViewModel.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 18.01.2024.
//

import Combine
import Foundation

final class CoinDetailViewModel: ObservableObject {
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coinDetailDataService = .init(coin: coin)
        addSubscribers()
    }

    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .sink { returnedCoinDetails in
                dump(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}
