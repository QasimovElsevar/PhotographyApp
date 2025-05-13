//
//  NewCollectionManager.swift
//  PhotographyApp
//
//  Created by Elsever on 13.05.25.
//

import Foundation

class NewCollectionManager: NewCollectionUserCase {
    
    func createCollection(withName name: String, parameter: [String: Any], completion: @escaping (String?) -> Void) {
        
        FirestoreManager.shared.saveData(collectionType: .collectionOfPhotosCollection, docName: name, parameters: parameter, completion: completion)
    }
    
    
}
