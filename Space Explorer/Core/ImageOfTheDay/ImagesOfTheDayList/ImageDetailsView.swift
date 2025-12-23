//
//  ImageDetailsView.swift
//  Space Explorer
//
//  Created by Novus on 23/12/2025.
//

import SwiftUI

struct ImageDetailsView: View {
    
    let apod: APODViewData
    
    var body: some View {
        
        ScrollView {
            APODResultsView(apod: apod)
                .padding(.horizontal)
                .padding(.vertical, 8)
        }
        .toolbar { toolbarItems }
        .infinityFrame()
        .background(Color.appTheme.viewBackground)
    }
}

private extension ImageDetailsView {
    
    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        AppToolbar()
    }
    
    
    
}
