//
//  AppToolbar.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//

import SwiftUI

struct AppToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            HStack(spacing: 5) {
                Image(systemName: "globe")
                    .foregroundStyle(Color.appTheme.accent)
                Text("app_name")
                    .fontWeight(.semibold)
            }
        }
    }
}
