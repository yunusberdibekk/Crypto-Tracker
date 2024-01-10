//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 10.01.2024.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}
