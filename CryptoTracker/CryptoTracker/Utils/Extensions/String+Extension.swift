//
//  String+Extension.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        self.replacingOccurrences(of: "<[>]+>", with: "", options: .regularExpression)
    }
}
