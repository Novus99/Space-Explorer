//
//  SolarSystemView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import SwiftUI

struct ExplorePlanetsView: View {
    @StateObject private var viewModel = ExplorePlanetsViewModel()
    
    var body: some View {
        resultsView
        

    }
}

private extension ExplorePlanetsView {
    
    var resultsView: some View {
        ScrollView{
            VStack(spacing: 16) {
                SegmentedPickerView($viewModel.mode)
                switch viewModel.mode {
                case .solarSystem:
                    SolarSystemView()
                case .planetsList:
                    PlanetListView()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
    

    
}

#Preview {
    NavigationStack {
        ExplorePlanetsView()
    }
}
