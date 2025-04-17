//
//  ImageUserCase.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import Foundation

protocol ImageUserCase {
    func getPhoto(id: String) async throws -> PhotoDetails
    
    func getRelatedPhotos(query: String) async throws -> Search
    
    func likePhoto(id: String) async throws -> Photos
}
