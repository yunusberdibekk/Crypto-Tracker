//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 7.01.2024.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(.degrees(
                        (stat.percentageChange ?? 0) >= 0 ?
                            0 : 180
                    ))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(
                (stat.percentageChange ?? 0) >= 0 ?
                    Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        })
    }
}

#Preview {
    StatisticView(stat: .statistic1)
        .preferredColorScheme(.dark)
}
