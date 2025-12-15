//
//  RandomImageView.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

import SwiftUI

struct RandomImageView: View{
    
    var testAPI = APODRepositoryImpl()
    
    var body: some View {
        Text("Random Image View")
        getRandomImageButton
    }
}

private extension RandomImageView {
    var getRandomImageButton: some View {
            Button {
                Task {
                    let result = try? await testAPI.fetchRandomAPOD()
                    print(result as Any)
                }
            } label: {
                Text("Get random image")
                    .primaryButton()
            }
            .buttonStyle(PressableButtonStyle())
        }
}
