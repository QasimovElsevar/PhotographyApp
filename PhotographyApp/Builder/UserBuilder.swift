//
//  UserBuilder.swift
//  PhotographyApp
//
//  Created by Elsever on 29.03.25.
//

import Foundation

class UserBuilder {
    private var firstname: String?
    private var lastname: String?
    private var username: String?
    private var email: String?
    private var authToken: String?
    
    func set(firstname: String) {
        self.firstname = firstname
    }
    
    func set(lastname: String) {
        self.lastname = lastname
    }
    
    func set(username: String) {
        self.username = username
    }
    
    func set(email: String) {
        self.email = email
    }
    
    func set(authToken: String) {
        self.authToken = authToken
    }
    
    func build() -> [String: Any] {
        return ["firstname": firstname ?? "",
                "lastname": lastname ?? "",
                "username": username ?? "",
                "email": email ?? "",
                "authToken": authToken ?? ""]
    }
}


