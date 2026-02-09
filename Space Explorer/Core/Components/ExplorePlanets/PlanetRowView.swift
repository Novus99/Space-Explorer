//
//  PlanetRowView.swift
//  Space Explorer
//
//  Created by Novus on 07/02/2026.
//

import SwiftUI

struct PlanetRowView: View {
    let planet: PlanetViewData
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(planet.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            MiniPlanetView(planetId: planet.id)
                .frame(width: 56, height: 56)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 72)
        .background(Color(.systemGray5))
        .cornerRadius(16)
        .shadow(radius: 4)
        // TODO: Tu porobić z app properties te wartości
    }
}

private extension PlanetRowView {
    
    var miniPlanet: some View {
        MiniPlanetView(planetId: planet.id)
    }
    
    var planetName: some View {
        Text(planet.name)
            .font(.headline)
    }
    
}

//#Preview
//HStack{
//    PlanetRowView(planet: <#T##PlanetViewData#>)
//}
