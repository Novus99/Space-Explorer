//
//  PlanetListView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import SwiftUI

struct PlanetListView: View {
    var body: some View {
        VStack{
            Text("Planet List View")
            goToPreviewButton
        }
        
    }
}

private extension PlanetListView {
    
    
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
