//
//  User.swift
//  PhotographyApp
//
//  Created by Elsever on 20.03.25.
//

import Foundation

struct UserModel {
    let firstName, lastName, username, email, accessId: String?
}

struct SenBack: Codable {
    let code: String?
}
