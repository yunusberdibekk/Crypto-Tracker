//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import SwiftUI

struct LaunchView: View {
    @Binding var showLaunchView: Bool
    @State private var loadingText: [String] = "Loading your portfolio...".map { String($0) }
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(content: {
            Color.launch.background
                .ignoresSafeArea()
            Image(.logoTransparent)
                .resizable()
                .frame(width: 100, height: 100)
            ZStack(content: {
                if showLoadingText {
                    HStack(spacing: 0, content: {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    })
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            })
            .offset(y: 70)
        })
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
