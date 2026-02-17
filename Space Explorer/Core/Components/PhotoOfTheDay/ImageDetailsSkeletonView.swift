//
//  ImageDetailsSkeletonView.swift
//  Space Explorer
//
//  Created by Novus on 18/02/2026.
//

import SwiftUI

struct ImageDetailsSkeletonView: View {
    
    private let spacing: CGFloat = 16
    
    var body: some View {
            detailsSkeleton
    }
}

private var detailsSkeleton: some View {
    VStack(alignment: .leading, spacing: 8) {
        
        RoundedRectangle(cornerRadius: 6)
            .frame(height: 12)
            .frame(width: 150)
            .frame(maxWidth: .infinity, alignment: .center)
            .skeleton()
        
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 150)
            .skeleton()

        RoundedRectangle(cornerRadius: 12)
            .frame(height: 250)
            .skeleton()

            RoundedRectangle(cornerRadius: 6)
                .frame(height: 12)
                .frame(width: 80)
                .frame(maxWidth: .infinity, alignment: .center)
                .skeleton()
    }
}


#Preview {
    ImageDetailsSkeletonView()
}
