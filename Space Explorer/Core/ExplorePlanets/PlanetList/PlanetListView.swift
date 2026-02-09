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
        .task {
            if viewModel.planets.isEmpty {
                viewModel.fetchPlanets()
            }
        }
    }
}

private extension PlanetListView {
    
    var planetList: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.planets) { planet in
                PlanetRowView(planet: planet)
            }
        }
    }
    
    var goToPreviewButton: some View {
        NavigationLink {
            PlanetInfoView()          // << tutaj przechodzisz
        } label: {
            Text("Get Started")
                .primaryButton()      // Twój styl tekstu/przycisku
        }
        .buttonStyle(PressableButtonStyle())  // „wciśnięcie” jak w Twoim .press
    }
}
