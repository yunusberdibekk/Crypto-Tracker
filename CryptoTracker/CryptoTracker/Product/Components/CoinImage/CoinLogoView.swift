//
//  CoinLogoView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 10.01.2024.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: CoinModel

    var body: some View {
        VStack(content: {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        })
    }
}

#Preview {
    CoinLogoView(coin: CoinModel.coin)
}
