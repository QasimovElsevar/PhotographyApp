//
//  Topics.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import Foundation

// MARK: - WelcomeElement
struct Topics: Codable {
    let id, slug, title, description: String?
    let publishedAt, updatedAt, startsAt: String?
    let endsAt, onlySubmissionsAfter: JSONNull?
    let visibility: Visibility?
    let featured: Bool?
    let totalPhotos: Int?
    let currentUserContributions: [JSONAny]?
    let totalCurrentUserSubmissions: TotalCurrentUserSubmissions?
    let links: WelcomeLinks?
    let mediaTypes: [AssetTypeElement]?
    let status: WelcomeStatus?
    let owners: [User]?
    let coverPhoto: Photos?
    let previewPhotos: [PreviewPhoto]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case title = "title"
        case description = "description"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case onlySubmissionsAfter = "only_submissions_after"
        case visibility = "visibility"
        case featured = "featured"
        case totalPhotos = "total_photos"
        case currentUserContributions = "current_user_contributions"
        case totalCurrentUserSubmissions = "total_current_user_submissions"
        case links = "links"
        case mediaTypes = "media_types"
        case status = "status"
        case owners = "owners"
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
    }
}

// MARK: - TopicSubmissions
struct TopicSubmissions: Codable {
    let foodDrink: FoodDrink?
       let travel, wallpapers,nature, blackAndWhite, texturesPatterns,the3DRenders, architectureInterior: The3_DRenders?
       let monochromatic: Monochromatic?
       let film, streetPhotography, people, animals: The3_DRenders?

    enum CodingKeys: String, CodingKey {
        case foodDrink = "food-drink"
        case wallpapers, nature
        case blackAndWhite = "black-and-white"
        case monochromatic
        case texturesPatterns = "textures-patterns"
        case the3DRenders = "3d-renders"
        case architectureInterior = "architecture-interior"
        case travel, film
        case streetPhotography = "street-photography"
        case people, animals
    }
}

// MARK: - FoodDrink
struct FoodDrink: Codable {
    let status: Status?
}

enum Status: String, Codable {
    case approved = "approved"
    case rejected = "rejected"
    case unevaluated = "unevaluated"
}

// MARK: - The3_DRenders
struct The3_DRenders: Codable {
    let status: The3DRendersStatus?
    let approvedOn: String?

    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}

enum The3DRendersStatus: String, Codable {
    case approved = "approved"
    case rejected = "rejected"
}

// MARK: - Monochromatic
struct Monochromatic: Codable {
    let status: The3DRendersStatus?
}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
    let linksSelf, html, photos: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos
    }
}

enum WelcomeStatus: String, Codable {
    case statusOpen = "open"
}

// MARK: - TotalCurrentUserSubmissions
struct TotalCurrentUserSubmissions: Codable {
}

enum Visibility: String, Codable {
    case featured = "featured"
}


