//
//  AddToCollectionUseCase.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import Foundation

protocol NewPhotoToCollectionUseCase {
    
    func getCollections() async throws -> [Collections]
    
    func addPhotoToCollection(id: String, collectionId: String) async throws -> CollectionsPhoto
    
    func deletePhotoFromCollection(id: String, collectionId: String) async throws -> CollectionsPhoto
}
