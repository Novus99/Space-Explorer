//
//  APODMediaThumbView.swift
//  Space Explorer
//
//  Created by Novus on 15/12/2025.
//

import SwiftUI

struct APODLargeImageView: View {
    let urlString: String

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
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
                ContentUnavailableView("Nie udało się wczytać zdjęcia", systemImage: "photo")
                    .frame(maxWidth: .infinity, minHeight: 280)
            @unknown default:
                EmptyView()
            }
        }
    }
}
