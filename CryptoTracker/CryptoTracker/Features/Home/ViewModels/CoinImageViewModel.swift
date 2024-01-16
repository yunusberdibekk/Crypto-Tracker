//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 24.12.2023.
//

import Combine
import Foundation
import SwiftUI

final class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let coin: CoinModel
    private let dataService: CoinImageService

    init(coin: CoinModel) {
        self.coin = coin
        dataService = CoinImageService(coin: coin)
        addSubscribers()
        isLoading = true
    }

    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
