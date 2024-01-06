//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ?
                .easeOut(duration: 1.0) : .none, value: animate)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
}
