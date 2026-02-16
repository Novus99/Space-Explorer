//
//  OrbitalInfoRow.swift
//  Space Explorer
//
//  Created by Novus on 16/02/2026.
//

import SwiftUI

struct OrbitalInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 12)
    }
}

