//
//  UserLoginModel.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation
import FirebaseFirestore

struct UserModel: Codable {
    let firstname, lastname, username, email, accessKey: String?
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
    let collectionName: String?
    let createdAt: Date?
    let photos: [UsersPhotos]
    let numberOfPhotos: Int
}
