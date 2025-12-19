//
//  APODThumbnailImageView.swift
//  Space Explorer
//
//  Created by Novus on 18/12/2025.
//

import SwiftUI

struct APODThumbnailImageView: View {
    let urlString: String?
    let size: CGFloat
    
    var body: some View {
        thumbnailImageView
    }
}

private extension APODThumbnailImageView {
    
    @ViewBuilder
    var thumbnailImageView: some View {
        Group{
            if let urlString,
               let url = URL(string: urlString),
               !urlString.isEmpty {
                
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        
                    case .failure:
                        defaultImage
                    @unknown default:
                        defaultImage
                    }
                }
            }
            else {
                defaultImage
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .clipped()
    }
    
    var defaultImage: some View {
        Image("default_image")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, minHeight: 280)
    }
    
}
