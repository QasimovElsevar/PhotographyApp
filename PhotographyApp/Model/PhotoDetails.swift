//
//  PhotoDetails.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct PhotoDetails: Codable {
    let id: String?
    let createdAt, updatedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let downloads, likes: Int?
    let likedByUser, publicDomain: Bool?
    let description: String?
    let exif: Exif?
    let location: Location?
    let tags: [Tag]?
    let currentUserCollections: [CurrentUserCollection]?
    let urls: Urls?
    let links: WelcomeLinks?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case blurHash = "blur_hash"
        case downloads, likes
        case likedByUser = "liked_by_user"
        case publicDomain = "public_domain"
        case description, exif, location, tags
        case currentUserCollections = "current_user_collections"
        case urls, links, user
    }
}

// MARK: - CurrentUserCollection
struct CurrentUserCollection: Codable {
    let id: Int?
    let title: String?
    let publishedAt, lastCollectedAt, updatedAt: String?
    let coverPhoto, user: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, title
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case coverPhoto = "cover_photo"
        case user
    }
}

// MARK: - Exif
struct Exif: Codable {
    let make, model, name, exposureTime: String?
    let aperture, focalLength: String?
    let iso: Int?

    enum CodingKeys: String, CodingKey {
        case make, model, name
        case exposureTime = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }
}

// MARK: - Location
struct Location: Codable {
    let city, country: String?
    let position: Position?
}

// MARK: - Position
struct Position: Codable {
    let latitude, longitude: Double?
}

