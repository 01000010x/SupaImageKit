//
//  SupaImageView.swift
//  SupaImageKit
//
//  Created by Baptiste Leguey on 03/05/2025.
//

import SwiftUI
import OSLog

struct SupaImageView<Downloader: ImageDownloaderProtocol, Content: View>: View where Downloader: Sendable {
    private let imageName: String
    private let cache: ImageCacheServiceProtocol
    private let downloader: Downloader
    private let bucketName: String
    private let content: (Image) -> Content
    
    // Logger
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "SupaImageView"
    )
    
    @State private var image: UIImage?
    
    init(
        imageName: String,
        bucketName: String,
        cache: ImageCacheServiceProtocol,
        downloader: Downloader,
        @ViewBuilder content: @escaping (Image) -> Content
    ) {
        self.imageName = imageName
        self.cache = cache
        self.downloader = downloader
        self.bucketName = bucketName
        self.content = content
    }
    
    var body: some View {
        Group {
            if let image {
                content(Image(uiImage: image))
            } else {
                content(Placeholder())
            }
        }
        .onAppear {
            if image == nil {
                Task {
                    await loadImage()
                }
            }
        }
    }
}

// MARK: - Subviews
private extension SupaImageView {
    func Placeholder() -> Image {
        Image(systemName: "photo")
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
            logger.error("[SupaImageKit] Failed to load image \(imageName): \(error.localizedDescription)")
        }
    }
}
