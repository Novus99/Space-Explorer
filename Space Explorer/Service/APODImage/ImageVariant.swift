//
//  ImageVariant.swift
//  Space Explorer
//
//  Created by Novus on 04/01/2026.
//

import CoreGraphics

enum ImageVariant: Hashable {
    case thumbnail(CGSize)
    case large(CGSize)
    
    var targetSize: CGSize {
        switch self {
        case .thumbnail(let size), .large(let size):
            return size
        }
    }
    
    var cacheSuffix: String {
        let s = targetSize
        return "\(Int(s.width))x\(Int(s.height))"
    }
}
