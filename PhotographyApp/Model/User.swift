//
//  User.swift
//  PhotographyApp
//
//  Created by Elsever on 20.03.25.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: String?
    let updatedAt: String?
    let username, name, firstName: String?
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos, totalPromotedPhotos: Int?
    let totalIllustrations, totalPromotedIllustrations: Int?
    let acceptedTos, forHire: Bool?
    let social: Social?

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalPromotedPhotos = "total_promoted_photos"
        case totalIllustrations = "total_illustrations"
        case totalPromotedIllustrations = "total_promoted_illustrations"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String?
}

// MARK: - Social
struct Social: Codable {
    let instagramUsername: String?
    let portfolioURL: String?
    let twitterUsername: String?
    let paypalEmail: JSONNull?

    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioURL = "portfolio_url"
        case twitterUsername = "twitter_username"
        case paypalEmail = "paypal_email"
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String?
    let portfolio, following, followers: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}
