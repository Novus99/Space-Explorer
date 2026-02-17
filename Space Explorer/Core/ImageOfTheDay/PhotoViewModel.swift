//
//  PhotoViewModel.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import Foundation
import Factory

@MainActor
final class PhotoViewModel: ObservableObject {
    @Injected(\.apodRepository) private var apodRepository
    
    @Published var mode: ImageOfTheDayMode = .imagesList
    @Published var randomApod: APODViewData?
    @Published var last30Apods: [APODViewData] = []
    @Published var isLoadingLast30 = false
    @Published var isLoadingRandomApod = false
    
    @MainActor
    func fetchRandomImage() async {
        isLoadingRandomApod = true
        defer { isLoadingRandomApod = false }
        
        do {
            let item = try await apodRepository.fetchRandomAPOD()
            randomApod = mapToUIModel(item)
        }
        catch {
            print("Errror while fetching random astronomy image: \(error)")
        }
    }
    
    @MainActor
    func fetchLast30Images() async {
        isLoadingLast30 = true
        defer { isLoadingLast30 = false }
        
        do {
            let items = try await apodRepository.fetchLast30APOD()
            last30Apods = items.map(mapToUIModel)
        }
        catch {
            print("Error while fetching last 30 astronomy image's: \(error)")
        }
    }
    
    private func mapToUIModel(_ item: APODItem) -> APODViewData {
        APODViewData(
            id: item.id,
            title: item.title,
            explaination: item.explanation,
            url: item.url?.absoluteString,
            date: item.date)
    }
    
}
