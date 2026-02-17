//
//  AppInfoModel.swift
//  Space Explorer
//
//  Created by Novus on 17/02/2026.
//


import Foundation

struct AppInfoModel {
    let name: String = NSLocalizedString("app_name", comment: "")
    let description: String = NSLocalizedString("app_description", comment: "")
    let developer: String = "Novus"
    let datasource: String = "https://api.nasa.gov"
    
    var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
    }
    
    var compatibility: String {
        if let minVersion = Bundle.main.infoDictionary?["MinimumOSVersion"] as? String {
            return "iOS \(minVersion)+"
        }
        return "-"
    }
}
