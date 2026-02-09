//
//  CardView.swift
//  Space Explorer
//
//  Created by Novus on 12/12/2025.
//

import SwiftUI

struct CardView: View {
    let date: String
    let urlString: String? // TODO: Zastanowic sie czy to powinno być optionalem
    
    var body: some View {
        HStack{
            cardImage
            datePlaceholder
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray5))
        .cornerRadius(16)
        .shadow(radius: 4)
        // TODO: Tu porobić z app properties te wartości
    }
}

private extension CardView {
    
    var cardImage: some View {
        APODThumbnailImageView(urlString: urlString, size: 60)
    }
    
    
    var datePlaceholder: some View {
        Text(
                String(
                    format: NSLocalizedString("photo_of_the_day.date_placeholder", comment: ""),
                    date
                    ))
    }
}

#Preview {
    HStack{
        CardView(date: "2025.12.14", urlString: "https://apod.nasa.gov/apod/image/9909/m83_aao_big.jpg")
        CardView(date: "2025.12.13", urlString: "https://apod.nasa.gov/apod/image/9908/augeclipse_cagas.jpg")
    }
}
