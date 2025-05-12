//
//  StorageManager.swift
//  PhotographyApp
//
//  Created by Elsever on 01.05.25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()

    private let storage = Storage.storage()
    
    func saveImage(images: [UIImage], completion: @escaping (String?, String?, String?) -> Void) {
        let storageRef = storage.reference()
        
        for image in images {
            let id = UUID().uuidString
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {return}
            
            let url = "image/\(id).jpg"
            let fileRef = storageRef.child(url)
            
            let _ = fileRef.putData(imageData, metadata: nil) { data, error in
                                
                if let error = error {
                    completion(nil, nil, error.localizedDescription)
                } else {
                    completion(id, url, nil)
                }
            }
        }
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?, String?) -> Void) {
        
        let storageRef = storage.reference()
        
        let fileRef = storageRef.child(url)
        fileRef.getData(maxSize: 5 * 1024 * 1024) { photos, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else {
                completion(UIImage(data: photos!), nil)
            }
        }
    }
}
