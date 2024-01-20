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

    func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
