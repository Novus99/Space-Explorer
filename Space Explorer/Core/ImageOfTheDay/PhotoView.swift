//
//  PhotoView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//
import SwiftUI

struct PhotoView: View {
    @StateObject private var viewModel = PhotoViewModel()
    
    var body: some View {
        VStack{
            resultsView
        }
        .task {
            if viewModel.randomApod == nil {
                await viewModel.fetchLast30Images()
                await viewModel.fetchRandomImage()
            }
        }
    }
}

private extension PhotoView {
    
    var resultsView: some View {
        ScrollView{
            VStack(spacing: 16) {
                SegmentedPickerView($viewModel.mode)
                switch viewModel.mode {
                case .imagesList:
                    imagesListView
                case .randomImage:
                    randomImageView
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .infinityFrame()
        .background(Color.appTheme.viewBackground)
    }
    
    @ViewBuilder
    var randomImageView: some View {
        RandomImageView(
            apod: viewModel.randomApod,
            onReload: {
                Task {
                    await viewModel.fetchRandomImage()
                }
            })
    }
    
    var imagesListView: some View {
        ImagesListView(
            apod: viewModel.last30Apods
        )
    }
    
}
