//
//  SupabaseImageView.swift
//  SupaImageKit
//
//  Created by Baptiste Leguey on 03/05/2025.
//

import Foundation
import SwiftUI
import Supabase

public enum CacheType {
    case memory, disk
}

public struct SupabaseImageView<Content: View>: View {
    private let imageName: String
    private let bucketName: String
    private let downloader: SupabaseImageDownloader
    private let cache: ImageCacheServiceProtocol
    private var isResizable: Bool = false
    private let content: (Image) -> Content
    
    public init(
        imageName: String,
        bucketName: String,
        client: SupabaseClient,
        cacheType: CacheType,
        @ViewBuilder content: @escaping (Image) -> Content
    ) {
        self.imageName = imageName
        self.bucketName = bucketName
        self.downloader = SupabaseImageDownloader(client: client)
        
        switch cacheType {
        case .disk:
            self.cache = OnDiskImageCache()
        case .memory:
            self.cache = InMemoryImageCache()
        }
        
        self.content = content
    }
    
    public var body: some View {
        SupaImageView(
            imageName: imageName,
            bucketName: bucketName,
            cache: cache,
            downloader: downloader
        ) { image in
            content(image)
        }
    }
}
