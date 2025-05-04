//
//  SupaBaseImageDownloader.swift
//  SupaImageKit
//
//  Created by Baptiste Leguey on 03/05/2025.
//

import Foundation
import Supabase

struct SupabaseImageDownloader: ImageDownloaderProtocol, Sendable {
    private let client: SupabaseClient
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    // Source is the bucket name in Supabase storage
    func downloadImage(named name: String, from source: String) async throws -> Data {
        return try await client
            .storage
            .from(source)
            .download(path: name)
    }
}
