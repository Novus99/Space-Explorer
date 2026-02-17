//
//  SettingsView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaultKeys.isDarkMode) private var isDarkMode = true
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                introBoxView
                customizationBoxView
                applicationBoxView
            }
            .padding()
        }
        .infinityFrame()
        .background(Color.appTheme.viewBackground)
    }
}


private extension SettingsView {
    
    var introBoxView: some View {
        IntroBoxView(data: .init(title: viewModel.getAppName(),sfSymbol: "info.circle", imageName: "AppIconImage", description: viewModel.getAppDescription()))
    }
    
    var customizationBoxView: some View {
        BoxView(data: .init(title: "Customization", sfSymbol: "paintbrush"))
        {
            Toggle("Dark Mode", isOn: $isDarkMode)
                .tint(.appTheme.accent)
        }
    }
    
    var applicationBoxView: some View {
        InfoBoxView(with: viewModel.applicationData)
    }
}

#Preview {
    SettingsView()
}
