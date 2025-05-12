//
//  UsersPhotoBuilder.swift
//  PhotographyApp
//
//  Created by Elsever on 12.05.25.
//

import Foundation

final class UsersPhotoBuilder {
    private var createdAt: Date?
    private var id: String?
    private var url: String?
    private var description: String?
    private var location: String?
    private var tags: String?
    
    func set(createdAt: Date) {
        self.createdAt = createdAt
    }
    
    func set(id: String) {
        self.id = id
    }
    
    func set(url: String) {
        self.url = url
    }
    
    func set(description: String) {
        self.description = description
    }
    
    func set(location: String) {
        self.location = location
    }
    
    func set(tags: String) {
        self.tags = tags
    }
    
    func build() -> [String: Any] {
        return ["id": id ?? "",
                "url": url ?? "",
                "createdAt": createdAt ?? "",
                "description": description ?? "",
                "location": location ?? "",
                "tags": tags ?? ""]
    }
}
