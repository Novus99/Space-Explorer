//
//  ImageDetailsSkeletonView.swift
//  Space Explorer
//
//  Created by Novus on 18/02/2026.
//

import SwiftUI

struct ImageDetailsSkeletonView: View {

    var body: some View {
        detailsSkeleton
    }
}

private extension ImageDetailsSkeletonView {
    var detailsSkeleton: some View {
        VStack(alignment: .leading, spacing: Layout.Spacing.s) {

            RoundedRectangle(cornerRadius: Layout.Radius.small)
                .frame(height: 12)
                .frame(width: 150)
                .frame(maxWidth: .infinity, alignment: .center)
                .skeleton()

            RoundedRectangle(cornerRadius: Layout.Radius.medium)
                .frame(height: 150)
                .skeleton()

            RoundedRectangle(cornerRadius: Layout.Radius.medium)
                .frame(height: 250)
                .skeleton()

            RoundedRectangle(cornerRadius: Layout.Radius.small)
                .frame(height: 12)
                .frame(width: 80)
                .frame(maxWidth: .infinity, alignment: .center)
                .skeleton()
        }
        .padding(Layout.Spacing.m)
    }
}

#Preview {
    ImageDetailsSkeletonView()
}
