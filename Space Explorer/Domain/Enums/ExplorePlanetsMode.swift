//
//  ExplorePlanetsMode.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import Foundation

enum ExplorePlanetsMode: CaseIterable, Hashable, CustomStringConvertible {
    case solarSystem
    case planetsList

    var description: String {
        switch self {
        case .solarSystem: "Solar System"
        case .planetsList: "Planets"
        }
    }
}
