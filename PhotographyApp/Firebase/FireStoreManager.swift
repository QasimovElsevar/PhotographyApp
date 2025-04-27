//
//  FireStoreManager.swift
//  PhotographyApp
//
//  Created by Elsever on 20.03.25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class FirestoreManager {
    
    enum UserDataCollections: String {
        case userDataCollection = "User Data"
        case likedPhotoCollection = "Liked Photos"
        case collectionOfPhotosCollection = "Collection of Photos"
    }
    
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
        
    func saveUser(firstName: String,
                  lastName: String,
                  username: String,
                  email: String,
                  accessKey: String,
                  completion: @escaping (String?) -> Void) {
        
        let data: [String: Any] = [
            "firstName" : firstName,
            "lastName" : lastName,
            "username" : username,
            "email" : email,
            "accessKey" : accessKey]
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(UserDataCollections.userDataCollection.rawValue)").document(firstName).setData(data) { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
    func getUserData(completion: @escaping (UserModel?, String?) -> Void) {
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(UserDataCollections.userDataCollection.rawValue)").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else {
                for docs in snapshot?.documents ?? [] {
                    let data = docs.data()
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let accessKey = data["accessKey"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let userData = UserModel(firstName: firstName, lastName: lastName, username: username, email: email, accessKey: accessKey)
                    UserDefaults.standard.set(accessKey, forKey: "Key")
                    completion(userData, nil)
                }
            }
        }
    }
    
    func updateUserData(firstName: String,
                        lastName: String,
                        username: String,
                        email: String,
                        accessKey: String,
                        completion: @escaping (String?) -> Void) {
        
        let data: [String: Any] = [
            "firstName" : firstName,
            "lastName" : lastName,
            "username" : username,
            "email" : email,
            "accessKey" : accessKey]
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(UserDataCollections.userDataCollection.rawValue)").document(firstName).updateData(data) { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                print("updated")
            }
        }
    }
    
    func saveUserPhoto(firstName: String,
                       lastName: String,
                       username: String,
                       email: String,
                       accessKey: String,
                       completion: @escaping (String?) -> Void) {
        
//        let data: [String: Any] = [
//            "firstName" : firstName,
//            "lastName" : lastName,
//            "username" : username,
//            "email" : email,
//            "accessKey" : accessKey]
//        
//        guard let document = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        
//        db.collection(userDataCollection).document(document).setData(data) { error in
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                completion(nil)
//            }
//        }
    }
    
    func saveUsersLikedPhotos(photoUrl: String, authorsName: String, photoId: String, blurHash: String, completion: @escaping (String?) -> Void) {
        
        let data: [String: Any] = [
            "photoUrl": photoUrl,
            "authorsName": authorsName,
            "photoId": [photoId],
            "blurHash": blurHash
        ]
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(UserDataCollections.likedPhotoCollection.rawValue)").document(photoId).setData(data) { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
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
    
    func getUsersLikedPhotos(completion: @escaping ([LikedPhotos]?, String?) -> Void) {
        var photoArray: [LikedPhotos] = []
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(collection) \(UserDataCollections.likedPhotoCollection.rawValue)").getDocuments(source: .default) { snapshot, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else {
                for docs in snapshot?.documents ?? [] {
                    let data = docs.data()
                    let photoUrl = data["photoUrl"] as? String ?? ""
                    let authorsName = data["authorsName"] as? String ?? ""
                    let photoId = data["photoId"] as? String ?? ""
                    let blurHash = data["blurHash"] as! String
                    let likedPhotos =  LikedPhotos(id: photoId, url: photoUrl, author: authorsName, blurHash: blurHash)
                    photoArray.append(likedPhotos)
                    completion(photoArray, nil)
                }
            }
        }
    }
    
    
}
