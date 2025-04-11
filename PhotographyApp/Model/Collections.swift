//
//  Collections.swift
//  PhotographyApp
//
//  Created by Elsever on 01.04.25.
//

import Foundation

// MARK: - WelcomeElement
struct Collections: Codable {
    let id, title: String?
    let description: String?
    let publishedAt, lastCollectedAt, updatedAt: String?
    let featured: Bool?
    let totalPhotos: Int?
    let welcomePrivate: Bool?
    let shareKey: String?
    let tags: [Tag]?
    let links: WelcomeLinks?
            let user: User?
            let coverPhoto: Photos?
            let previewPhotos: [PreviewPhoto]?
    
            enum CodingKeys: String, CodingKey {
                case id, title, description
                case publishedAt = "published_at"
                case lastCollectedAt = "last_collected_at"
                case updatedAt = "updated_at"
                case featured
                case totalPhotos = "total_photos"
                case welcomePrivate = "private"
                case shareKey = "share_key"
                case tags, links, user
                case coverPhoto = "cover_photo"
                case previewPhotos = "preview_photos"
            }
        }
    
        // MARK: - PurpleTopicSubmissions
        struct PurpleTopicSubmissions: Codable {
            let blue, texturesPatterns, wallpapers, nature: Blue?
            let spring: Spring?
    
            enum CodingKeys: String, CodingKey {
                case blue
                case texturesPatterns = "textures-patterns"
                case wallpapers, nature, spring
            }
        }

        // MARK: - Blue
        struct Blue: Codable {
            let status: String?
        }
    //
        // MARK: - Spring
        struct Spring: Codable {
            let status: String?
            let approvedOn: String?
    
            enum CodingKeys: String, CodingKey {
                case status
                case approvedOn = "approved_on"
            }
        }
    

    // MARK: - Tag
    struct Tag: Codable {
        let type: TypeEnum?
        let title: String?
        let source: Source?
    }
    
    // MARK: - Source
    struct Source: Codable {
        let ancestry: Ancestry?
        let title, subtitle, description: String?
        let redirect: JSONNull?
        let metaTitle, metaDescription: String?
        let coverPhoto: SourceCoverPhoto?
        let affiliateSearchQuery: JSONNull?
        
        enum CodingKeys: String, CodingKey {
            case ancestry, title, subtitle, description, redirect
            case metaTitle = "meta_title"
            case metaDescription = "meta_description"
            case coverPhoto = "cover_photo"
            case affiliateSearchQuery = "affiliate_search_query"
        }
    }
    
    // MARK: - Ancestry
    struct Ancestry: Codable {
        let type, category, subcategory: Category?
    }
    
    // MARK: - Category
    struct Category: Codable {
        let slug, prettySlug: String?
        let redirect: JSONNull?
        
                enum CodingKeys: String, CodingKey {
                    case slug
                    case prettySlug = "pretty_slug"
                    case redirect
                }
            }
        
            // MARK: - SourceCoverPhoto
            struct SourceCoverPhoto: Codable {
                let id, slug: String?
                let alternativeSlugs: AlternativeSlugs?
                let createdAt, updatedAt, promotedAt: String?
                let width, height: Int?
                let color, blurHash: String?
                let description: JSONNull?
                let altDescription: String?
                let breadcrumbs: [JSONAny]?
                let urls: Urls?
                let links: PhotoLinks?
                let likes: Int?
                let likedByUser: Bool?
                let currentUserCollections: [JSONAny]?
                let sponsorship: JSONNull?
                let topicSubmissions: FluffyTopicSubmissions?
                let assetType: AssetTypeElement?
                let premium, plus: Bool?
                let user: User?
        
                enum CodingKeys: String, CodingKey {
                    case id, slug
                    case alternativeSlugs = "alternative_slugs"
                    case createdAt = "created_at"
                    case updatedAt = "updated_at"
                    case promotedAt = "promoted_at"
                    case width, height, color
                    case blurHash = "blur_hash"
                    case description
                    case altDescription = "alt_description"
                    case breadcrumbs, urls, links, likes
                    case likedByUser = "liked_by_user"
                    case currentUserCollections = "current_user_collections"
                    case sponsorship
                    case topicSubmissions = "topic_submissions"
                    case assetType = "asset_type"
                    case premium, plus, user
                }
            }
        
            // MARK: - FluffyTopicSubmissions
            struct FluffyTopicSubmissions: Codable {
                let architectureInterior: Blue?
        
                enum CodingKeys: String, CodingKey {
                    case architectureInterior = "architecture-interior"
                }
            }
        
        enum TypeEnum: String, Codable {
            case landingPage = "landing_page"
            case search = "search"
        }
        
         
