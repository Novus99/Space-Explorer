//
//  PlanetListView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import SwiftUI

struct PlanetListView: View {
    @StateObject private var viewModel = PlanetListViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            planetList
            Spacer()
        }
    }
}

private extension PlanetListView {
    
    var planetList: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.planets) { planet in
                NavigationLink(destination: PlanetDetailsView(planet: planet)) {
                    PlanetRowView(planet: planet)
                }
            }
        }
    }
}

