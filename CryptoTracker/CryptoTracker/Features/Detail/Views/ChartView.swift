//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import SwiftUI

struct ChartView: View {
    @State private var percentage: CGFloat = .zero

    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date

    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60) // 7D, 24H, 60M, 60S
    }

    var body: some View {
        VStack(content: {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
            chartDateLabels
                .padding(.horizontal, 4)
        })
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: .coin)
}

extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10.0)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20.0)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30.0)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40.0)
        }
    }

    private var chartBackground: some View {
        VStack(content: {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        })
    }

    private var chartYAxis: some View {
        VStack(content: {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        })
    }

    private var chartDateLabels: some View {
        HStack(content: {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        })
    }
}
