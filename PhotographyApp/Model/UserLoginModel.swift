//
//  UserLoginModel.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation
import FirebaseFirestore

struct UserModel: Codable {
    let id, firstname, lastname: String?
    let username, email, profilePhoto, accessKey: String?
    let createdAt: Date?
}

struct SenBack: Codable {
    let code: String?
}

struct UsersPhotos: Codable {
    let id: String?
    let url: String?
    let blurHash: String?
    let author: String?
    let createdAt: Date?
}

struct UsersCollections: Codable {
    let id: String?
    let collectionName: String?
    let publishedAt: Date?
    var photos: [UsersPhotos]
    let numberOfPhotos: Int?
}
