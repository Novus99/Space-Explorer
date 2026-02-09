//
//  ExplorePlanetsMode.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import Foundation

enum ExplorePlanetsMode: CaseIterable, Hashable, CustomStringConvertible {
    case planetList
    case solarSystem
    

    var description: String {
        switch self {
        case .planetList: String(localized: "picker_view.planets")
        case .solarSystem: String(localized: "picker_view.solar_system")
        }
    }
}
