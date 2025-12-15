//
//  APODItem.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import Foundation

struct APODItem: Identifiable, Codable {
    var id: String { date }

    let date: String
    let title: String
    let explanation: String
    let url: URL
    let hdurl: URL?
    let mediaType: MediaType
    let serviceVersion: String
    let copyright: String?

    enum CodingKeys: String, CodingKey {
        case date
        case title
        case explanation
        case url
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case copyright
    }
}
