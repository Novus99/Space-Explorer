//
//  APODRepositoryImpl.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import Foundation
import Factory

final class APODRepositoryImpl: APODRepository {
    
    @Injected(\.dateGenerator)
    private var dateGenerator: DateGenerator
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchRandomAPOD() async throws -> APODItem {
        let randomDate = dateGenerator.randomDateString()
        let url = APODEndpoint.randomAPOD(date: randomDate, apiKey: APIKeys.nasa).url
        
        let(data, response) = try await session.data(from: url) // TODO: tu ogarnąć response
        
        print("Raw API response: ")
        print(String(data: data, encoding: .utf8) ?? "Decoding to UTF-8 was not succesful")
    
        let decoder = JSONDecoder()
        let item = try decoder.decode(APODItem.self, from: data)

        return item
    }
    
    func fetchLast30APOD() async throws -> [APODItem] {
        let startDate = dateGenerator.todayMinus30DaysDateString()
        let endDate = dateGenerator.todayDateString()
        
        let url = APODEndpoint.last30APOD(start_date: startDate, end_date: endDate, apiKey: APIKeys.nasa).url
        
        let(data, response) = try await session.data(from: url)
        
        print("Raw API response: ")
        print(String(data: data, encoding: .utf8) ?? "Decoding to UTF-8 was not succesful")
        
        let decoder = JSONDecoder()
        let items = try decoder.decode([APODItem].self, from: data)
        
        return items
    }
    
}
