//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 24.12.2023.
//

import Combine
import Foundation
import SwiftUI

final class CoinImageService {
    @Published var image: UIImage? = nil

    private var imageSubscription: AnyCancellable?
    private let fileManager: LocalFileManager
    private let coin: CoinModel
    private let imageName: String
    private let folderName: String = "coin_images"

    init(coin: CoinModel, fileManager: LocalFileManager = LocalFileManager.shared) {
        self.coin = coin
        self.imageName = coin.id
        self.fileManager = fileManager
        getCoinImage()
    }

    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap { data -> UIImage? in
                UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
