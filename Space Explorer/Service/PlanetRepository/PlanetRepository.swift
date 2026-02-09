//
//  PlanetRepository.swift
//  Space Explorer
//
//  Created by Novus on 07/02/2026.
//

import Foundation

protocol PlanetRepository {
    func fetchPlanets() -> [PlanetItem]
}
