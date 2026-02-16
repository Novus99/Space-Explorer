//
//  PlanetListViewModel.swift
//  Space Explorer
//
//  Created by Novus on 12/12/2025.
//

import Foundation
import Factory

@MainActor
final class PlanetListViewModel: ObservableObject {
    @Injected(\.planetRepository) private var planetRepository
    
    @Published var planets: [PlanetViewData] = []
    
    
    init() {
            let items = planetRepository.fetchPlanets()
            planets = items.map(mapToUIModel)
    }
    
    private func mapToUIModel(_ item: PlanetItem) -> PlanetViewData {
        PlanetViewData(
            id: item.id,
            order: item.order,
            visual: PlanetVisual(from: item.visual),
            name: item.nameEN,
            description: item.descriptionEN,
            thumbnailAsset: item.thumbnailAsset,
            radius: item.radius,
            periphelium: item.perihelion,
            aphelium: item.aphelion)
    }
}


