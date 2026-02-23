//
//  ImagesListSkeletonView.swift
//  Space Explorer
//
//  Created by Novus on 18/02/2026.
//

import SwiftUI

struct ImagesListSkeletonView: View {

    private let columnCount = 2
    private let spacing: CGFloat = Layout.Spacing.m

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
        VStack(alignment: .leading, spacing: Layout.Spacing.m) {

            RoundedRectangle(cornerRadius: Layout.Radius.medium)
                .frame(height: 150)
                .skeleton()
        }
    }
}
