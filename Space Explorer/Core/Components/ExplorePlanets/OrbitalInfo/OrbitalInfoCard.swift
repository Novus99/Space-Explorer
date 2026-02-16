//
//  OrbitalInfo.swift
//  Space Explorer
//
//  Created by Novus on 16/02/2026.
//

import SwiftUI

struct OrbitalInfoCard: View {
    let header: String
    let rows: [(title: String, value: String)]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(header)
                .font(.headline)

            VStack(spacing: 0) {
                ForEach(Array(rows.enumerated()), id: \.offset) { index, row in
                    OrbitalInfoRow(title: row.title, value: row.value)

                    if index < rows.count - 1 {
                        Divider()
                    }
                }
            }
        }
        .padding(16)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
