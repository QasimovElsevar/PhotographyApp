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
    
    func getAPhoto(id: String, completion: @escaping ([UsersPhotos]?, String?) -> Void)
    
    func likePhoto(id: String, parameter: [String: Any], completion: @escaping (String?) -> Void)
    
    func unlikePhoto(id: String, completion: @escaping (String?) -> Void)
    
    func checkLike(completion: @escaping ([UsersPhotos]?, String?) -> Void)
    
    func deletePhoto(id: String, completion: @escaping (String?) -> Void)
}
