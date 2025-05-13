//
//  UserCollectionUserCase.swift
//  PhotographyApp
//
//  Created by Elsever on 21.04.25.
//

import Foundation

protocol UserCollectionUserCase {
    
    func getUsersCollection(id: String, completion: @escaping ([UsersCollections]?, String?) -> Void)
    
    func deleteCollection(collectionsName: String, completion: @escaping (String?) -> Void)
}
