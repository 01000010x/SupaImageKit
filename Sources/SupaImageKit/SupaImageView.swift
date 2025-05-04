//
//  SupaImageView.swift
//  SupaImageKit
//
//  Created by Baptiste Leguey on 03/05/2025.
//

import SwiftUI

struct SupaImageView<Downloader: ImageDownloaderProtocol>: View where Downloader: Sendable {
    private let imageName: String
    private let cache: ImageCacheServiceProtocol
    private let downloader: Downloader
    private let bucketName: String
    
    @State private var image: UIImage?
    
    init(
        imageName: String,
        bucketName: String,
        cache: ImageCacheServiceProtocol,
        downloader: Downloader
    ) {
        self.imageName = imageName
        self.cache = cache
        self.downloader = downloader
        self.bucketName = bucketName
    }
    
    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
        } else {
            Placeholder()
                .onAppear {
                    Task {
                        await loadImage()
                    }
                }
        }
    }
}

// MARK: - Subviews
private extension SupaImageView {
    func Placeholder() -> some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.gray)
    }
}

// MARK: - Utilities
private extension SupaImageView {
    func loadImage() async {
        // Check cache for image first
        if let cached = cache.loadImage(named: imageName) {
            self.image = cached
            return
        }
        
        // Then request the image if not in cache
        do {
            let data = try await Task.detached(priority: .utility) {
                try await downloader.downloadImage(named: imageName, from: bucketName)
            }.value
            
            if let downloaded = UIImage(data: data) {
                try? cache.cacheImage(downloaded, with: imageName)
                self.image = downloaded
            }
        } catch {
            // TODO: Manage an error state on the image or a retry
            print("[SupaImageKit] Failed to load image \(imageName): \(error.localizedDescription)")
        }
    }
}
