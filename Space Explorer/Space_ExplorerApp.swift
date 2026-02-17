//
//  Space_ExplorerApp.swift
//  Space Explorer
//
//  Created by Novus on 10/12/2025.
//

import SwiftUI

@main
struct Space_ExplorerApp: App {
    @AppStorage(UserDefaultKeys.isDarkMode) private var isDarkMode: Bool = true
    
    var body: some Scene {
        WindowGroup {
            HomeTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
