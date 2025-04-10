//
//  PreviewPhotos.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

// MARK: - PreviewPhoto
struct PreviewPhoto: Codable {
    let id, slug: String?
    let createdAt, updatedAt: String?
    let blurHash: String?
    let assetType: AssetTypeElement?
    let urls: Urls?
    
    enum CodingKeys: String, CodingKey {
        case id, slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case assetType = "asset_type"
        case urls
    }
}
