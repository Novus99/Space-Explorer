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
    @Published var last30Apods: [APODViewData]?
    
    @MainActor
    func fetchRandomImage() async {
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
        do {
            let items = try await apodRepository.fetchLast30APOD()
            last30Apods = items.map(mapToUIModel)
            print(last30Apods!)
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
