//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 16.01.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack(content: {
            if let coin {
                DetailView(coin: coin)
            }
        })
    }
}

struct DetailView: View {
    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
    }

    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: .coin)
}
