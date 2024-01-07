//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 7.01.2024.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var viewModel: HomeViewModel

    var body: some View {
        HStack(content: {
            ForEach(viewModel.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(
                        width: UIScreen.main.bounds.width / 3)
            }
        })
        .frame(width: UIScreen.main.bounds.width,
               alignment: .center)
    }
}

#Preview {
    HomeStatsView()
        .environmentObject(HomeViewModel())
}
