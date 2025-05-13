//
//  AddToCollectionUseCase.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import Foundation

protocol NewPhotoToCollectionUseCase {
    
    func getCollections(completion: @escaping ([UsersCollections]?, String?) -> Void)
    
    func addPhotoToCollection(collectionName: String, parameter: [String: Any], completion: @escaping (String?) -> Void)
    
    func deletePhotoFromCollection(collectionName: String, photoId: String, completion: @escaping (String?) -> Void)
    
    func updateNumberOfPhotosInCollection(collectionName: String, parameter: [String: Any], completion: @escaping (String?) -> Void)
}
