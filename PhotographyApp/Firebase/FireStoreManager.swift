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
        
//    func updateUserData(firstName: String,
//                        lastName: String,
//                        username: String,
//                        email: String,
//                        accessKey: String,
//                        completion: @escaping (String?) -> Void) {
//        
//        let data: [String: Any] = [
//            "firstName" : firstName,
//            "lastName" : lastName,
//            "username" : username,
//            "email" : email,
//            "accessKey" : accessKey]
//        
//        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        
//        db.collection("\(collection) \(UserDataCollections.userDataCollection.rawValue)").document(firstName).updateData(data) { error in
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                print("updated")
//            }
//        }
//    }
    func saveImage(images: [UIImage], completion: @escaping (StorageMetadata?, String?) -> Void) {
        let storageRef = storage.reference()
        
        for image in images {
            var id = UUID().uuidString
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {return}
            
            let url = "image/\(id).jpg"
            let fileRef = storageRef.child(url)
            
            let uploadTask = fileRef.putData(imageData, metadata: nil) { data, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                } else {
                    let data = ["id": id,
                                "url": url,
                                "createdAt": Date()]
                    
                    self.saveData(collectionType: .userPhotos, docName: "\(id) images", parameters: data) { error in
                        if let error = error {
                            completion(nil, error)
                        } 
                    }
                }
            }
        }
    }
    
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
    
    func deleteUsersUnlikedPhoto(photoId: String, completion: @escaping (String?) -> Void) {
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(UserDataCollections.likedPhotoCollection.rawValue)").document(photoId).delete() { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
    func addPhotoToCollection(collectionName: String, photoUrl: String, authorName: String, completion: @escaping (String?) -> Void) {
        
        let photos = ["photoUrl": photoUrl,
                      "authorName": authorName]
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(UserDataCollections.collectionOfPhotosCollection.rawValue)").document((collectionName)).updateData(["photos": FieldValue.arrayUnion([photos])]) { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
//    func deleteCollection(collectionName: String, photo: String, completion: @escaping (String?) -> Void) {
//        
//        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        
//        db.collection("\(collection) \(UserDataCollections.collectionOfPhotosCollection.rawValue)").document((collectionName)).delete() { error in
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    
//    func deletePhotoFromCollection(collectionName: String, photoUrl: String, authorName: String, completion: @escaping (String?) -> Void) {
//        
//        let photos = ["photoUrl": photoUrl,
//                      "authorName": authorName]
//        
//        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        
//        db.collection("\(collection) \(UserDataCollections.collectionOfPhotosCollection.rawValue)").document((collectionName)).updateData(["photoUrl": FieldValue.arrayRemove([photos])]) { error in
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    
//    func getCollection(completion: @escaping ([UsersCollections]?, String?) -> Void) {
//        var collectionArray: [UsersCollections] = []
//        
//        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        
//        db.collection("\(collection) \(UserDataCollections.collectionOfPhotosCollection.rawValue)").getDocuments(source: .default) { snapshot, error in
//            if let error = error {
//                completion(nil, error.localizedDescription)
//            } else {
//                for docs in snapshot?.documents ?? [] {
//                    let data = docs.data()
//                    let collectionName = data["collectionName"] as? String ?? ""
//                    let photos = data["photos"] as? [UsersPhotos] ?? []
//                    let collection = UsersCollections(collectionName: collectionName, photos: photos)
//                    collectionArray.append(collection)
//                    completion(collectionArray, nil)
//                }
//            }
//        }
//    }
}
