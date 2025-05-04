//
//  ImageCacheServiceProtocol.swift
//  SupaImageKit
//
//  Created by Baptiste Leguey on 03/05/2025.
//
import Foundation
import UIKit

protocol ImageCacheServiceProtocol {
    func loadImage(named name: String) -> UIImage?
    func cacheImage(_ image: UIImage, with name: String) throws
}
