//
//  PhotoView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//
import SwiftUI

struct PhotoView: View {
    @StateObject private var viewModel =
    PhotoViewModel()
    var body: some View {
        resultsView
    }
}

private extension PhotoView {
    
    var resultsView: some View {
        ScrollView{
            VStack(spacing: 16) {
                SegmentedPickerView($viewModel.mode)
                switch viewModel.mode {
                case .imagesList:
                    ImagesListView()
                case .randomImage:
                    RandomImageView()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}
