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
    var speedRange: ClosedRange<CGFloat> = 8...10
    var animationDelay: Double = 0.25

    @State private var start: Date = .now
    @State private var animate = false
    @State private var speed: CGFloat = 9

    var body: some View {
        ZStack {
            // ✅ Zawsze widoczna planeta (bez animacji) — zero “pustki”
            staticPlanet
                .opacity(animate ? 0 : 1)

            // ✅ Animacja uruchamia się chwilę później
            if animate {
                scrollingPlanet
                    .transition(.opacity)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .shadow(radius: 3, y: 2)
        .onAppear {
            if speed == 9 {
                speed = .random(in: speedRange)
            }

            start = .now
            animate = false
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                start = .now
                withAnimation(.easeOut(duration: 0.2)) {
                    animate = true
                }
            }
        }
    }
}

private extension MiniPlanetView {
    var staticPlanet: some View {
        Image("\(planetId)_diffuse")
            .resizable()
            .interpolation(.high)
            .scaledToFill()
    }

    var scrollingPlanet: some View {
        TimelineView(.animation) { context in
            GeometryReader { geo in
                let w = geo.size.width
                let elapsed = context.date.timeIntervalSince(start)
                let shift = CGFloat(elapsed) * speed
                let x = -(shift.truncatingRemainder(dividingBy: w))

                HStack(spacing: 0) {
                    planetImage(width: w, height: geo.size.height)
                    planetImage(width: w, height: geo.size.height) // ✅ 2 kopie wystarczą
                }
                .offset(x: x)
                .clipped()
            }
        }
    }

    func planetImage(width: CGFloat, height: CGFloat) -> some View {
        Image("\(planetId)_diffuse")
            .resizable()
            .interpolation(.high)
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
    }
}
