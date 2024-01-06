//
//  UIWindow+Extension.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Foundation
import UIKit

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
