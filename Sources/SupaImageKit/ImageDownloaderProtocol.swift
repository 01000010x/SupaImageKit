//
//  ImageDownloaderProtocol.swift
//  SupaImageKit
//
//  Created by Baptiste Leguey on 03/05/2025.
//
import Foundation

protocol ImageDownloaderProtocol {
    func downloadImage(named name: String, from source: String) async throws -> Data
}
