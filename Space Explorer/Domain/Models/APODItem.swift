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
    let url: URLRequest
    let hdURL: URL?
    let mediaType: MediaType
    let serviceVersion: String
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case date, title, explanation, url, hdurl, copyright
        case mediaType = "media_type"
        case serviceVersion = "service_version"
    }
}
