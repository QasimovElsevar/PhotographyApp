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
                print(UserDefaults.standard.integer(forKey: "userID"))
                completion(nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "userID")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func printCurrentUser() {
        print(Auth.auth().currentUser?.email)
    }
}
