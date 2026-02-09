//
//  PlanetRepositoryImpl.swift
//  Space Explorer
//
//  Created by Novus on 07/02/2026.
//

import Foundation

final class PlanetRepositoryImpl: PlanetRepository {
    func fetchPlanets() -> [PlanetItem] {
            guard
                let url = Bundle.main.url(forResource: "Planets", withExtension: "json"),
                let data = try? Data(contentsOf: url),
                let planets = try? JSONDecoder().decode([PlanetItem].self, from: data)
            else {
                return []
            }
            return planets.sorted { $0.order < $1.order }
        }
}
