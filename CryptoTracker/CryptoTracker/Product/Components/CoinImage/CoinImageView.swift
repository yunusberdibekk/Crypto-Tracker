//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 24.12.2023.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var viewModel: CoinImageViewModel

    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }

    var body: some View {
        ZStack(content: {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        })
    }
}

#Preview {
    CoinImageView(coin: CoinModel.coin)
}
