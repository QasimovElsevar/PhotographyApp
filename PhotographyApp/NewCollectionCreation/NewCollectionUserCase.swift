//
//  NewCollectionUserCase.swift
//  PhotographyApp
//
//  Created by Elsever on 13.05.25.
//

import Foundation

protocol NewCollectionUserCase {
    
    func createCollection(withName name: String, parameter: [String: Any], completion: @escaping (String?) -> Void)
}
