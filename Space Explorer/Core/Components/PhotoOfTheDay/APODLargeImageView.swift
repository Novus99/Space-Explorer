//
//  APODMediaThumbView.swift
//  Space Explorer
//
//  Created by Novus on 15/12/2025.
//

import SwiftUI

struct APODLargeImageView: View {
    let urlString: String?

    var body: some View {
        if let urlString,
           let url = URL(string: urlString),
           !urlString.isEmpty {
            
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 280)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                case .failure:
                    defaultImage
                @unknown default:
                    defaultImage
                }
            }
        } else {
            defaultImage
        }
    }

    private var defaultImage: some View {
        Image("default_image")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, minHeight: 280)
    }
}

#Preview {
    Group{
        APODLargeImageView(urlString: nil)
        APODLargeImageView(urlString: "https://apod.nasa.gov/apod/image/0711/holmes_peris.jpg")
        APODLargeImageView(urlString: "https://www.youtube.com/embed/CC7OJ7gFLvE?rel=0")
        
    }
}
