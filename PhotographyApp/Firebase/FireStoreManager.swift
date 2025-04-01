//
//  FireStoreManager.swift
//  PhotographyApp
//
//  Created by Elsever on 20.03.25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func saveUser(firstName: String, lastName: String, username: String, email: String, accessKey: String, completion: @escaping (String?) -> Void) {
        let data: [String: Any] = [
            "firstName" : firstName,
            "lastName" : lastName,
            "username" : username,
            "email" : email,
            "accessKey" : accessKey]
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("\(firstName):  \(collection)").document(firstName).setData(data) { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
    func getUserData(completion: @escaping (UserModel?, String?) -> Void)  {
        
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection("Trying:  \(collection)").getDocuments { snapshot, error in
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
}
