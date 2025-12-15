//
//  PhotoViewModel.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import Foundation

@MainActor
final class PhotoViewModel: ObservableObject {
    @Published var mode: ImageOfTheDayMode = .imagesList
}
