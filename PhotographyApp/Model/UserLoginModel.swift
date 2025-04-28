//
//  UserLoginModel.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

struct UserModel {
    let firstName, lastName, username, email, accessKey: String?
}

struct SenBack: Codable {
    let code: String?
}

struct LikedPhotos {
    let id: String?
    let url: String?
    let blurHash: String?
    let author: String?
}

struct UsersCollections {
    let collectionName: String?
    let photos: [LikedPhotos]
}
