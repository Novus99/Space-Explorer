//
//  ImagePipeline.swift
//  Space Explorer
//
//  Created by Novus on 04/01/2026.
//

import UIKit
import ImageIO

protocol ImageProviding {
    func image(from url: URL, variant: ImageVariant) async throws -> UIImage
}

enum ImagePipelineError: Error {
    case invalidImageData
}

final class ImagePipeline: ImageProviding {

    private let cache: ImageCaching
    private let session: URLSession

    init(cache: ImageCaching = ImageMemoryCache(),
         session: URLSession = .shared) {
        self.cache = cache
        self.session = session
    }

    func image(from url: URL, variant: ImageVariant) async throws -> UIImage {
        let key = cacheKey(url: url, variant: variant)

        if let cached = cache.image(forKey: key) {
            return cached
        }

        let (data, _) = try await session.data(from: url)

        guard let downsampled = downsample(data: data, to: variant.targetSize, scale: UIScreen.main.scale) else {
            throw ImagePipelineError.invalidImageData
        }

        cache.insert(downsampled, forKey: key)
        return downsampled
    }

    private func cacheKey(url: URL, variant: ImageVariant) -> String {
        return url.absoluteString + "|" + variant.cacheSuffix
    }

    private func downsample(data: Data, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale

        let options: [CFString: Any] = [
            kCGImageSourceShouldCache: false,
            kCGImageSourceTypeIdentifierHint: "public.jpeg"
        ]

        guard let source = CGImageSourceCreateWithData(data as CFData, options as CFDictionary) else {
            return UIImage(data: data)
        }

        let downsampleOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: Int(maxDimensionInPixels)
        ]

        guard let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions as CFDictionary) else {
            return UIImage(data: data)
        }

        return UIImage(cgImage: cgImage)
    }
}
