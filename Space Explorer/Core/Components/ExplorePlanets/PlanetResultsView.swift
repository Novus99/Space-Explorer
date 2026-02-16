//
//  PlanetResultsView.swift
//  Space Explorer
//
//  Created by Novus on 16/02/2026.
//

import SwiftUI

public struct PlanetResultsView: View {
    
    let planet: PlanetViewData
    
    public var body: some View {
        VStack(spacing: 20){
            planetName
            planet3DModel
            planetDescription
            Spacer()
            orbitalInfo
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color(.systemGray5))
        .cornerRadius(.cell)
        
    }
}


private extension PlanetResultsView {
    
    var planetName: some View {
        Text(planet.name)
            .font(.callout)
            .fontWeight(.bold)
    }
    
    var planet3DModel: some View {
        PlanetRealityView(
            planetId: planet.id,
            visual: planet.visual,
            baseRadius: 1.2,
            planetDiameterFraction: 0.8)
        .frame(width:260, height: 260)
    }
    
    var planetDescription: some View {
        Text(planet.description)
            .font(.callout)
            .fontWeight(.semibold)
    }
    
    var orbitalInfo: some View {
        OrbitalInfoCard(
            header: "Orbital Data",
            rows: [
                ("Perihelion", "\(planet.periphelium) km"),
                ("Aphelion", "\(planet.aphelium) km"),
                ("Radius", "\(planet.radius) km")
            ])
    }
    
}

#Preview {
    PlanetResultsView(planet: PlanetViewData(
        id: "sun",
        order: 1,
        visual: .standard,
        name: "Sun",
        description: "xx",
        thumbnailAsset: "sun",
        radius: 100,
        periphelium: 150,
        aphelium: 200
    ))
}
