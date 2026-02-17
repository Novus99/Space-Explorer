//
//  ImagesListView.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import SwiftUI

struct ImagesListView: View {
    
    let apod: [APODViewData]?
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
        VStack{
            apodGridView
        }
        
    }
}

private extension ImagesListView {
    
    var apodGridView: some View {
        LazyVGrid(columns: columns) {
            ForEach(Array((apod ?? []).reversed())) { item in
                NavigationLink(destination: ImageDetailsView(apod: item)) {
                    CardView(
                        urlString: item.url)
                }
                
            }
        }
    }
    
    
}

#Preview {
    //ImagesListView()
}

