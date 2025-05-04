//
//  InMemoryImageCache.swift
//  SupaImageKit
//
//  Created by Baptiste Leguey on 03/05/2025.
//

import Foundation
import UIKit

/// A memory implementation of the cache service protocol
final class InMemoryImageCache: ImageCacheServiceProtocol {
    private var storage = [String: UIImage]()
    
    init() {}
    
    func loadImage(named name: String) -> UIImage? {
        storage[name]
    }
    
    func cacheImage(_ image: UIImage, with name: String) throws {
        storage[name] = image
    }
}
