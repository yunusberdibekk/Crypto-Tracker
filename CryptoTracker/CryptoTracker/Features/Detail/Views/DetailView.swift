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
    @StateObject var viewModel: CoinDetailViewModel

    init(coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: .init(coin: coin))
    }

    var body: some View {
        Text("Hello")
    }
}

#Preview {
    DetailView(coin: .coin)
}
