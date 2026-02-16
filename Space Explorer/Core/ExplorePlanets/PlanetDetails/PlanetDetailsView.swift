//
//  PlanetInfoView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import SwiftUI

struct PlanetDetailsView: View {
    let planet: PlanetViewData
    
    var body: some View {
        resultsView
            .toolbar { toolbarItems }
            .infinityFrame()
            .background(Color.appTheme.viewBackground)
    }
}

private extension PlanetDetailsView {
    
    var resultsView: some View {
        GeometryReader { geo in
            ScrollView {
                PlanetResultsView(planet: planet)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: geo.size.height)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        AppToolbar()
    }
}

