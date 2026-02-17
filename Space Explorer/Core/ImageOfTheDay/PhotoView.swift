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
            if viewModel.randomApod == nil && viewModel.last30Apods.isEmpty {
                   async let last30: Void = viewModel.fetchLast30Images()
                   async let random: Void = viewModel.fetchRandomImage()
                   _ = await (last30, random)
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
                    if viewModel.isLoadingLast30 && viewModel.last30Apods.isEmpty {
                            ImagesListSkeletonView()
                        } else {
                            imagesListView
                        }
                case .randomImage:
                    if viewModel.isLoadingRandomApod && viewModel.randomApod == nil {
                        ImageDetailsSkeletonView()
                    } else {
                        randomImageView
                    }
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
