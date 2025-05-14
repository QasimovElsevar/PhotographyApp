//
//  UserBuilder.swift
//  PhotographyApp
//
//  Created by Elsever on 29.03.25.
//

import Foundation

final class UserBuilder {
    private var id: String?
    private var firstname: String?
    private var lastname: String?
    private var username: String?
    private var email: String?
    private var accessKey: String?
    
    func set(id: String) {
        self.id = id
    }
    
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
    
    func set(accessKey: String) {
        self.accessKey = accessKey
    }
    
    func build() -> [String: Any] {
        return ["id": id ?? "",
                "firstname": firstname ?? "",
                "lastname": lastname ?? "",
                "username": username ?? "",
                "email": email ?? "",
                "accessKey": accessKey ?? "",
                "createdAt": Date()]
    }
}


