//
//  PlanetItem.swift
//  Space Explorer
//
//  Created by Novus on 07/02/2026.
//
struct PlanetItem: Identifiable, Codable {
    let id: String
    let order: Int
    let visual: String

    let namePL: String
    let nameEN: String
    let descriptionPL: String
    let descriptionEN: String

    let thumbnailAsset: String

    let radius: Int
    let perihelion: Int
    let aphelion: Int
}
