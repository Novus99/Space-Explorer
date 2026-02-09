//
//  ImageLoader.swift
//  Space Explorer
//
//  Created by Novus on 04/01/2026.
//

import UIKit

@MainActor
final class ImageLoader: ObservableObject {
    @Published private(set) var image: UIImage?
    @Published private(set) var isLoading: Bool = false

    private let pipeline: ImageProviding

    init(pipeline: ImageProviding) {
        self.pipeline = pipeline
    }

    func load(url: URL, variant: ImageVariant) async {
        if isLoading { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let img = try await pipeline.image(from: url, variant: variant)
            self.image = img
        } catch {
            // TODO: error state
        }
    }
}
