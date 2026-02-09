//
//  ContentView.swift
//  Space Explorer
//
//  Created by Novus on 10/12/2025.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView{
            planetsTabItemView
            photosTabItemView
            settingsTabItemView
        }
    }
}

private extension HomeTabView {
    var planetsTabItemView: some View {
        NavigationStack {
            ExplorePlanetsView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarItems }
        }
        .tabItem {
            Image(systemName: "globe")
            Text("tab.explore_planets")
        }
    }

    var photosTabItemView: some View {
        NavigationStack {
            PhotoView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarItems }
        }
        .tabItem {
            Image(systemName: "camera")
            Text("tab.photo_of_the_day")
        }
    }

    var settingsTabItemView: some View {
        SettingsView()
            .tabItem {
                Image(systemName: "gearshape")
                Text("tab.settings")
            }
    }

    
    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        AppToolbar()
    }

}

#Preview {
    HomeTabView()
}
