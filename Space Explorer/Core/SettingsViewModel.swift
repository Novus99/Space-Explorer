//
//  SettingsViewModel.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import Foundation
import Factory

@MainActor
final class SettingsViewModel: ObservableObject {
    @Injected(\.appInfoModel) var appInfoModel
    
    
    var applicationData: InfoBoxView.Data {
        .init(
             title: "Application",
             sfSymbol: "apps.iphone",
             infoData: [
                .init(title: NSLocalizedString("settings_view_developer", comment: ""), description: appInfoModel.developer),
                .init(title: NSLocalizedString("settings_view_version", comment: ""), description: appInfoModel.version),
                .init(title: NSLocalizedString("settings_view_compatibility", comment: ""), description: appInfoModel.compatibility),
                .init(title: NSLocalizedString("settings_view_datasource", comment: ""), urlString: appInfoModel.datasource)
             ])
    }
    
    func getAppName() -> String {
        appInfoModel.name
    }
    
    func getAppDescription() -> String {
        appInfoModel.description
    }
}
