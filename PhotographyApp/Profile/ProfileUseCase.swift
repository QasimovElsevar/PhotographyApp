//
//  ProfileUseCase.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import Foundation

protocol ProfileUseCase {
    
    func getUser(completion: @escaping ([UserModel]?, String?) -> Void)
    
    func getUsersPhotos(completion: @escaping ([UsersPhotos]?, String?) -> Void)
    
    func getUsersLikedPhotos(completion: @escaping ([UsersPhotos]?, String?) -> Void)
    
    func getUsersCollections(completion: @escaping ([UsersCollections]?, String?) -> Void)

}
