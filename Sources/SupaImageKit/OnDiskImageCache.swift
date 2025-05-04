//
//  OnDiskImageCache.swift
//  SupaImageKit
//
//  Created by Baptiste Leguey on 03/05/2025.
//

import Foundation
import UIKit

final class OnDiskImageCache: ImageCacheServiceProtocol {
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    init(subfolder: String = "SupaImageCache") {
        let cachesURL = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first!
        
        self.cacheDirectory = cachesURL.appendingPathComponent(subfolder)
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }
    
    func loadImage(named name: String) -> UIImage? {
        let path = cacheDirectory.appendingPathComponent(name)
        return UIImage(contentsOfFile: path.path)
    }
    
    func cacheImage(_ image: UIImage, with name: String) throws {
        let path = cacheDirectory.appendingPathComponent(name)
        // TODO: This could be delegated to a CompressionService with its own implementation
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "DiskImageCache", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Could not convert image to JPEG"])
        }
        try data.write(to: path, options: .atomic)
    }
}
