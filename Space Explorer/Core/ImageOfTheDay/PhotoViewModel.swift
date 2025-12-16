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
    
    private func mapToUIModel(_ item: APODItem) -> APODViewData {
        APODViewData(title: item.title, explaination: item.explanation, url: item.url, date: item.date)
    }
    
}
