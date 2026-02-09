//
//  MiniPlanetView.swift
//  Space Explorer
//
//  Created by Novus on 09/02/2026.
//

import SwiftUI

struct MiniPlanetView: View {
    let planetId: String
    var size: CGFloat = 56
    var speed: CGFloat = .random(in: 8...10)

    @State private var start = Date()

    var body: some View {
        TimelineView(.animation) { context in
            GeometryReader { geo in
                let w = geo.size.width
                let elapsed = context.date.timeIntervalSince(start)
                let shift = CGFloat(elapsed) * speed
                let x = -(shift.truncatingRemainder(dividingBy: w))

                ZStack {
                    HStack(spacing: 0) {
                        planetImage(width: w, height: geo.size.height)
                        planetImage(width: w, height: geo.size.height)
                        planetImage(width: w, height: geo.size.height)
                    }
                    .offset(x: x)
                }
                .frame(width: w, height: geo.size.height)
                .clipShape(Circle())
            }
        }
        .frame(width: size, height: size)
        .onAppear { start = Date() }
        // opcjonalnie lekki cień, żeby “żyło”
        .shadow(radius: 3, y: 2)
    }

    @ViewBuilder
    private func planetImage(width: CGFloat, height: CGFloat) -> some View {
        Image("\(planetId)_diffuse")
            .resizable()
            .interpolation(.high)
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
    }
}
