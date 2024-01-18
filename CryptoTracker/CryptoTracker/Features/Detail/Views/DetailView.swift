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
    private let columns: [GridItem] = [.init(.flexible()), .init(.flexible())]
    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: .init(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20, content: {
                Text("")
                    .frame(height: 150)
                overviewTitle
                Divider()
                overviewGrid
                additionalTitle
                Divider()
                additionalGrid
            })
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: .coin)
    }
}

extension DetailView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            content: {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }

    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            content: {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
}
