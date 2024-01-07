//
//  UIApplication+Extension.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 7.01.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
