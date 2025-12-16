//
//  RandomImageView.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import SwiftUI

struct RandomImageView: View{
    
    let apod: APODViewData?
    
    let onReload: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            apodResults
            getRandomImageButton
        }
    }
}

private extension RandomImageView {
    var getRandomImageButton: some View {
        Button {
            onReload()
        } label: {
            Text("Get random image")
                .primaryButton()
        }
        .buttonStyle(PressableButtonStyle())
    }
    
    var apodResults: some View { // TODO: To do poprawki
            Group {
                if let apod {
                    APODResultsView(apod: apod)
                } else {
                    // placeholder, gdy jeszcze nic nie wczytano
                    Text("Tap the button to load a random image")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }

