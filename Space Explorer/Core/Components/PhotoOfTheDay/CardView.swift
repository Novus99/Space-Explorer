//
//  CardView.swift
//  Space Explorer
//
//  Created by Novus on 12/12/2025.
//

import SwiftUI

struct CardView: View {
    let urlString: String? // TODO: Zastanowic sie czy to powinno być optionalem
    
    var body: some View {
    cardImage
        .cornerRadius(16)
        .shadow(radius: 4)
        // TODO: Tu porobić z app properties te wartości
    }
}

private extension CardView {
    
    var cardImage: some View {
        APODThumbnailImageView(urlString: urlString, size: 180)
    }

}

#Preview {
    HStack{
        CardView(urlString: "https://apod.nasa.gov/apod/image/9909/m83_aao_big.jpg")
        CardView(urlString: "https://apod.nasa.gov/apod/image/9908/augeclipse_cagas.jpg")
    }
}
