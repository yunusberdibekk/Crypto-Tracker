//
//  Color+Extension.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color(.accent)
    let background = Color(.background)
    let green = Color(.colorGreen)
    let red = Color(.colorRed)
    let secondaryText = Color(.secondaryText)
}

struct LaunchTheme {
    let accent = Color(.launchAccent)
    let background = Color(.launchBackground)
}
