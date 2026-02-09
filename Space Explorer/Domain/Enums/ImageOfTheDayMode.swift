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
        case .imagesList: String(localized: "picker_view.latest_images")
        case .randomImage: String(localized: "picker_view.random_image")
        }
    }
}
