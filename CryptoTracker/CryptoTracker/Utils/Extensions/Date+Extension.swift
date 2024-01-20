//
//  Date+Extension.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import Foundation

extension Date {
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }

    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    func asShortDateString() -> String {
        shortFormatter.string(from: self)
    }
}
