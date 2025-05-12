//
//  FireStoreManager.swift
//  PhotographyApp
//
//  Created by Elsever on 20.03.25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

final class FirestoreManager {
    
    enum UserDataCollections: String {
        case userDataCollection = "User Data"
        case likedPhotoCollection = "Liked Photos"
        case collectionOfPhotosCollection = "Collection of Photos"
        case userPhotos = "User Photos"
    }
    
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private let storage = Storage.storage()
        
    private init() {}
        
    func saveData(collectionType: UserDataCollections, docName: String, parameters: [String: Any], completion: @escaping (String?) -> Void) {
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(collectionType.rawValue)").document(docName).setData(parameters) { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
    func getData<T: Codable>(collectionType: UserDataCollections, model: T.Type, completion: @escaping ([T]?, String?) -> Void) {
        
        var array: [T] = []
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(collectionType.rawValue)").order(by: "createdAt", descending: true).getDocuments(source: .default) { document, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else if let document = document {
                do {
                        for docs in document.documents {
                            let data = try docs.data(as: T.self)
                            array.append(data)
                    }
                    completion(array, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
    
    func getADocument<T: Codable>(collectionType: UserDataCollections, id: String, model: T.Type, completion: @escaping ([T]?, String?) -> Void) {
        
        var array: [T] = []
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(collectionType.rawValue)").whereField("id", isEqualTo: id).getDocuments(source: .default) { document, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else if let document = document {
                do {
                        for docs in document.documents {
                            let data = try docs.data(as: T.self)
                            array.append(data)
                    }
                    completion(array, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
    
    func deleteDocument(collectionType: UserDataCollections, docName: String, completion: @escaping (String?) -> Void) {
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(collectionType.rawValue)").document(docName).delete() { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
    func updateData(docName: String,
                    updatedField: String,
                    parameters: [String: Any],
                    deleteField: Bool = false,
                    completion: @escaping (String?) -> Void) {
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        var updatedNewField: [String: Any] = [:]
        
        if deleteField {
            updatedNewField[updatedField] = FieldValue.arrayRemove([parameters])
        } else {
            if updatedField == "photos" {
                updatedNewField[updatedField] = FieldValue.arrayUnion([parameters])
            } else {
                updatedNewField = parameters
            }
        }
        
        db.collection("\(collection) \(UserDataCollections.collectionOfPhotosCollection.rawValue)")
            .document(docName)
            .updateData(updatedNewField) { error in
                completion(error?.localizedDescription)
            }
    }
}
