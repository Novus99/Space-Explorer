//
//  SkeletonModifier.swift
//  Space Explorer
//
//  Created by Novus on 18/02/2026.
//

import SwiftUI

struct SkeletonModifier: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .overlay(shimmer)
            .mask(content)
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }

    private var shimmer: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.gray.opacity(0.3),
                Color.gray.opacity(0.1),
                Color.gray.opacity(0.3)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .rotationEffect(.degrees(30))
        .offset(x: isAnimating ? 300 : -300)
    }
}

extension View {
    func skeleton() -> some View {
        self
            .foregroundColor(.gray.opacity(0.3))
            .modifier(SkeletonModifier())
    }
}

