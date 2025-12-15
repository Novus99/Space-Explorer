//
//  ImageOfTheDayMode.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import Foundation

enum ImageOfTheDayMode: CaseIterable, Hashable,
                        CustomStringConvertible {
    case imagesList
    case randomImage
    
    var description: String {
        switch self {
        case .imagesList: "Latest Images"
        case .randomImage: "Random Image"
        }
    }
}
