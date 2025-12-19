//
//  APODResultsView.swift
//  Space Explorer
//
//  Created by Novus on 15/12/2025.
//

import SwiftUI

struct APODResultsView: View {
    
    let apod: APODViewData
    
    var body: some View {
        VStack{
            title
            image
            description
            date
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color.appTheme.cellBackground)
        .cornerRadius(.cell)
    }
}

private extension APODResultsView {
    var title: some View {
        Text(apod.title)
            .font(.callout)
            .fontWeight(.semibold)
    }
    
    
    var image: some View {
        APODLargeImageView(urlString: apod.url) // TODO: To zmienić na string już w modelu
    }
    
    var description: some View {
        Text(apod.explaination)
    }
    
    var date: some View {
        Text("Date: \(apod.date)") // TODO: To wyciągnąć do innego pliku (Date:)
    }
}

#Preview {
    APODResultsView(
        apod: APODViewData(
            id: "1999-09-26",
            title: "M83: A Barred Spiral Galaxy",
            explaination: "M83 is a bright spiral galaxy that can be found with a small telescope in the constellation of Hydra.  It takes light about 15 million years to reach us from M83.  M83 is quite a typical spiral - much like our own Milky Way Galaxy. Spiral galaxies contains many billions of stars, the youngest of which inhabit the spiral arms and glow strongly in blue light.  Dark dust lanes are mixed in with the stars and help define M83's marked spiral structure.  The space between the spiral arms is also filled with stars - but stars that are typically more dim and red. The stars and gas in spiral arms seem to be responding to much more mass than is visible here, implying that galaxies are predominantly composed of some sort of dark matter. Finding the nature of this dark matter remains one of the great challenges of modern science.",
            url: "https://apod.nasa.gov/apod/image/9909/m83_aao.jpg",
            date: "1999-09-26")
    )
}
