//
//  ImagesListSkeletonView.swift
//  Space Explorer
//
//  Created by Novus on 18/02/2026.
//

import SwiftUI

struct ImagesListSkeletonView: View {

    private let columnCount = 2
    private let spacing: CGFloat = 16

    var body: some View {
        LazyVGrid(
            columns: Array(repeating: .init(.flexible(), spacing: spacing), count: columnCount),
            spacing: spacing
        ) {
            ForEach(0..<8, id: \.self) { _ in
                skeletonCard
            }
        }
    }

    private var skeletonCard: some View {
        VStack(alignment: .leading, spacing: 8) {

            RoundedRectangle(cornerRadius: 12)
                .frame(height: 150)
                .skeleton()

//            RoundedRectangle(cornerRadius: 6)
//                .frame(height: 14)
//                .skeleton()

//            RoundedRectangle(cornerRadius: 6)
//                .frame(height: 12)
//                .frame(maxWidth: 100, alignment: .leading)
//                .skeleton()
        }
    }
}
