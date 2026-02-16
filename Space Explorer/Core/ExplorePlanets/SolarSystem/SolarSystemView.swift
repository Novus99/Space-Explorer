//
//  SolarSystemView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import SwiftUI

struct SolarSystemView: View {
    var body: some View {
            VStack {
                Text("Solar system view")

                SolarSystemRealityView()
                    .aspectRatio(1, contentMode: .fit) // kwadrat
                    .background(.black)
                goToPreviewButton
            }
            .padding()
        }
    }

private extension SolarSystemView {
    
    var goToPreviewButton: some View {
       Text("dummy")
    }
}
