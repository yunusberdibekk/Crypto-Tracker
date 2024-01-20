//
//  SectionRowView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import SwiftUI

struct SectionRowView: View {
    let destination: URL
    let imageName: String
    let backgroundColor: Color
    let text: String

    var body: some View {
        Link(destination: destination, label: {
            HStack(content: {
                Image(systemName: imageName)
                    .renderingMode(.template)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(8)
                    .background(backgroundColor)
                    .clipShape(.rect(cornerRadius: 8))
                Text(text)
            })
        })
    }
}

#Preview {
    SectionRowView(destination: URL(string: "https://www.apple.com")!, imageName: "heart.fill", backgroundColor: .blue, text: "Visit Apple")
}
