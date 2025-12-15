//
//  APODRepository.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import Foundation

protocol APODRepository {
    func fetchRandomAPOD() async throws -> APODItem
    func fetchLast30APOD() async throws -> [APODItem]
}
