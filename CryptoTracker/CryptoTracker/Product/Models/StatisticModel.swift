//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 7.01.2024.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?

    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }

    static let statistic1: StatisticModel = .init(
        title: "Market Cap",
        value: "$12.58n",
        percentageChange: 25.34
    )

    static let statistic2: StatisticModel = .init(
        title: "Total Volume",
        value: "$1.23Tr"
    )

    static let statistic3: StatisticModel = .init(
        title: "Portfolio Value",
        value: "$50.4k",
        percentageChange: -12.34
    )
}
