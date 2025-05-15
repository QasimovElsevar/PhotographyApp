//
//  FireBaseController.swift
//  MovieApp
//
//  Created by Elsever on 19.02.25.
//

import Foundation
import FirebaseAuth

final class FireBaseManager {
    
    static let shared = FireBaseManager()
    
    var completion: (() -> Void)?
    
    private init() {}
    
    var isUserSignedIn: Bool {
           return Auth.auth().currentUser != nil
       }
    
    func registerUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            } else if let result = result  {
                UserDefaults.standard.set(result.user.uid, forKey: "userID")
                completion(nil)
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            } else if let result = result {
                UserDefaults.standard.set(result.user.uid, forKey: "userID")
                completion(nil)
            }
        }
    }
    
    func signOut(completion: @escaping (String?) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "userID")
            completion(nil)
        } catch {
            completion(error.localizedDescription)
        }
    }
    
    func deleteUser(completion: @escaping (String?) -> Void) {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
    func changePassword(completion: @escaping (String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: Auth.auth().currentUser!.email ?? "") { error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
}
