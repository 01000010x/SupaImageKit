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

public struct SupabaseImageView: View {
    private let imageName: String
    private let bucketName: String
    private let downloader: SupabaseImageDownloader
    private let cache: ImageCacheServiceProtocol
    
    public init(
        imageName: String,
        bucketName: String,
        client: SupabaseClient,
        cacheType: CacheType
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
    }
    
    public var body: some View {
        SupaImageView(
            imageName: imageName,
            bucketName: bucketName,
            cache: cache,
            downloader: downloader
        )
    }
}
