//
//  CachedImageView.swift
//  Space Explorer
//
//  Created by Novus on 04/01/2026.
//

import SwiftUI

struct CachedImageView: View {
    let url: URL?
    let variant: ImageVariant

    @StateObject private var loader: ImageLoader

    init(url: URL?, variant: ImageVariant, pipeline: ImageProviding = ImagePipeline()) {
        self.url = url
        self.variant = variant
        _loader = StateObject(wrappedValue: ImageLoader(pipeline: pipeline))
    }

    var body: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .task(id: taskID) {
            guard let url else { return }
            await loader.load(url: url, variant: variant)
        }
    }

    private var taskID: String {
        guard let url else { return "nil" }
        return url.absoluteString + "|" + variant.cacheSuffix
    }
}
