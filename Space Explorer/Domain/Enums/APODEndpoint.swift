//
//  APODEndpoint.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import Foundation

enum APODEndpoint {
    static let baseURL = URL(string: "https://api.nasa.gov")!
    
    case randomAPOD(date: String, apiKey: String)
    
    case last30APOD(start_date: String, end_date: String, apiKey: String)
    
    var url: URL {
        switch self {
        case .randomAPOD(let date, let apiKey):
            var components = URLComponents(
                url: Self.baseURL.appendingPathComponent("planetary/apod"),
                resolvingAgainstBaseURL: false
            )!
            
            components.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "date", value: date)
            ]
            
            return components.url!
            
        case .last30APOD(start_date: let startDate, end_date: let endDate, apiKey: let apiKey):
            var components = URLComponents(
                url: Self.baseURL.appendingPathComponent("planetary/apod"),
                resolvingAgainstBaseURL: false
                )!
            
            components.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "start_date", value: startDate),
                URLQueryItem(name: "end_date", value: endDate)
                ]
            
            return components.url!
        }
    }
}
