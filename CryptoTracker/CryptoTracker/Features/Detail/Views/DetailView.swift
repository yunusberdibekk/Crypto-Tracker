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
    @State private var showFullDescription: Bool = false
    @StateObject var viewModel: CoinDetailViewModel
    private let columns: [GridItem] = [.init(.flexible()), .init(.flexible())]
    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: .init(coin: coin))
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(content: {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                VStack(spacing: 20, content: {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                })
                .padding()
            })
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(viewModel.coin.name)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            }
        })
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

    private var navigationBarTrailingItems: some View {
        HStack(content: {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        })
    }

    private var descriptionSection: some View {
        ZStack(content: {
            if let coinDescription = viewModel.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading, content: {
                    Text(coinDescription)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                        .lineLimit(showFullDescription ? .max : 3)
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                    .tint(.blue)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        })
    }

    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            if let websiteString = viewModel.websiteURL,
               let url = URL(string: websiteString)
            {
                Link("Website", destination: url)
            }

            if let redditString = viewModel.redditURL,
               let url = URL(string: redditString)
            {
                Link("Reddit", destination: url)
            }
        })
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
