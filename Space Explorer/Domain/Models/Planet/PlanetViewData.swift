//
//  PlanetViewData.swift
//  Space Explorer
//
//  Created by Novus on 07/02/2026.
//

import Foundation

struct PlanetViewData: Identifiable {
    let id: String
    let order: Int
    let visual: PlanetVisual
    let name: String
    let description: String
    let thumbnailAsset: String
    let radius: Int
    let periphelium: Int
    let aphelium: Int
}

