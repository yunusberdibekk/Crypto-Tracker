//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI

struct CoinRowView: View {
    @Binding var coin: CoinModel
    let showHoldingsColumn: Bool

    var body: some View {
        HStack(spacing: 0, content: {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        })
        .font(.subheadline)
        .background(Color.theme.green.opacity(0.001))
    }
}

#Preview {
    CoinRowView(coin: .constant(CoinModel.coin), showHoldingsColumn: true)
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0, content: {
            Text(coin.rank.description)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        })
    }

    private var centerColumn: some View {
        VStack(alignment: .trailing, content: {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        })
        .foregroundStyle(Color.theme.accent)
    }

    private var rightColumn: some View {
        VStack(alignment: .trailing, content: {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text((coin.priceChangePercentage24H ?? 0).asPercentString())
                .foregroundStyle((coin.priceChange24H ?? 0) > 0 ?
                    Color.theme.green :
                    Color.theme.red)
        })
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
