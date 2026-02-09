//
//  ImageCache.swift
//  Space Explorer
//
//  Created by Novus on 04/01/2026.
//

import UIKit

protocol ImageCaching {
    func image(forKey key: String) -> UIImage?
    func insert(_ image: UIImage, forKey key: String)
}

final class ImageMemoryCache: ImageCaching {
    private let cache = NSCache<NSString, UIImage>()

    init(countLimit: Int = 300) {
        cache.countLimit = countLimit
    }

    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func insert(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
