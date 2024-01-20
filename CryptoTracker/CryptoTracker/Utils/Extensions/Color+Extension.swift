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

struct ColorTheme2 {
    let accent = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    let background = Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
    let green = Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
    let red = Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))
    let secondaryText = Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
}

struct LaunchTheme {
    let accent = Color(.launchAccent)
    let background = Color(.launchBackground)
}
