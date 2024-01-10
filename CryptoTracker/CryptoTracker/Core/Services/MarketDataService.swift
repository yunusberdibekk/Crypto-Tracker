//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 10.01.2024.
//

import Combine
import Foundation

final class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?

    init() {
        getMarketData()
    }

    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        // TODO: -Burada networking manager dışarıdan alınabilir. Alınacak network manager direkt network service protocol türünde olabilir.
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
