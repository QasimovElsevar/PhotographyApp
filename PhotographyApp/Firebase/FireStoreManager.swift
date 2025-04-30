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
        
//    func saveUser(firstName: String,
//                  lastName: String,
//                  username: String,
//                  email: String,
//                  accessKey: String,
//                  completion: @escaping (String?) -> Void) {
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
//        db.collection("\(collection) \(UserDataCollections.userDataCollection.rawValue)").document(firstName).setData(data) { error in
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                completion(nil)
//            }
//        }
//    }
    
//    func getUserData(completion: @escaping (UserModel?, String?) -> Void) {
//        
//        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        
//        db.collection("\(collection) \(UserDataCollections.userDataCollection.rawValue)").getDocuments { snapshot, error in
//            if let error = error {
//                completion(nil, error.localizedDescription)
//            } else {
//                for docs in snapshot?.documents ?? [] {
//                    let data = docs.data()
//                    let firstName = data["firstName"] as? String ?? ""
//                    let lastName = data["lastName"] as? String ?? ""
//                    let username = data["username"] as? String ?? ""
//                    let accessKey = data["accessKey"] as? String ?? ""
//                    let email = data["email"] as? String ?? ""
//                    let userData = UserModel(firstName: firstName, lastName: lastName, username: username, email: email, accessKey: accessKey)
//                    UserDefaults.standard.set(accessKey, forKey: "Key")
//                    completion(userData, nil)
//                }
//            }
//        }
//    }
    
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
    
//    func saveUsersLikedPhotos(photoUrl: String, authorsName: String, photoId: String, blurHash: String, completion: @escaping (String?) -> Void) {
//        
//        let data: [String: Any] = [
//            "url": photoUrl,
//            "author": authorsName,
//            "id": photoId,
//            "blurHash": blurHash
//        ]
//        
//        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        
//        db.collection("\(collection) \(UserDataCollections.likedPhotoCollection.rawValue)").document(photoId).setData(data) { error in
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                completion(nil)
//            }
//        }
//    }
    
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
                    print(error.localizedDescription)
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
    
//    func getUsersLikedPhotos(completion: @escaping ([LikedPhotos]?, String?) -> Void) {
//        var photoArray: [LikedPhotos] = []
//        
//        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        
//        db.collection("\(collection) \(UserDataCollections.likedPhotoCollection.rawValue)").getDocuments(source: .default) { snapshot, error in
//            if let error = error {
//                completion(nil, error.localizedDescription)
//            } else {
//                for docs in snapshot?.documents ?? [] {
//                    do {
//                        let data = try docs.data(as: LikedPhotos.self)
//                        photoArray.append(data)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                    let photoUrl = data["url"] as? String ?? ""
//                    let authorsName = data["author"] as? String ?? ""
//                    let photoId = data["id"] as? String ?? ""
//                    let blurHash = data["blurHash"] as? String ?? ""
//                    let likedPhotos =  LikedPhotos(id: photoId, url: photoUrl, blurHash: blurHash, author: authorsName)
//                    
//                    completion(photoArray, nil)
//                }
//            }
//        }
//    }
    
//    func createCollection(collectionName: String, photoUrl: String, authorName: String, completion: @escaping (String?) -> Void) {
//        
//        let photos = ["photoUrl": photoUrl,
//                      "authorName": authorName]
//        
//        let data: [String: Any] = [
//            "collectionName": collectionName,
//            "photos": FieldValue.arrayUnion([photos])
//        ]
//        
//        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//
//        db.collection("\(collection) \(UserDataCollections.collectionOfPhotosCollection.rawValue)").document((collectionName)).setData(data) { error in
//            
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                completion(nil)
//            }
//        }
//    }
    

    
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
//                    let photos = data["photos"] as? [LikedPhotos] ?? []
//                    let collection = UsersCollections(collectionName: collectionName, photos: photos)
//                    collectionArray.append(collection)
//                    completion(collectionArray, nil)
//                }
//            }
//        }
//    }
}
