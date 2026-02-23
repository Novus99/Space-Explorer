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
            VStack(spacing: Layout.Spacing.m) {
                SegmentedPickerView($viewModel.mode)
                switch viewModel.mode {
                case .planetList:
                    PlanetListView()
                case .solarSystem:
                    SolarSystemView()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, Layout.Padding.card)
        }
        .infinityFrame()
        .background(Color.appTheme.viewBackground)
    }
    

    
}

#Preview {
    NavigationStack {
        ExplorePlanetsView()
    }
}
