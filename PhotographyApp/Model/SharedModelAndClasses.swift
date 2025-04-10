//
//  SharedModelAndClasses.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

// MARK: - AlternativeSlugs
struct AlternativeSlugs: Codable {
    let en, es, ja, fr: String?
    let it, ko, de, pt: String?
}

enum AssetTypeElement: String, Codable {
    case illustration = "illustration"
    case photo = "photo"
}

// MARK: - CoverPhotoLinks
struct PhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb, smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

