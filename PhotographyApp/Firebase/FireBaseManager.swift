//
//  FireBaseController.swift
//  MovieApp
//
//  Created by Elsever on 19.02.25.
//

import Foundation
import FirebaseAuth

class FireBaseManager {
    
    static let shared = FireBaseManager()
    
    var completion: (() -> Void)?
    
    private init() {}
        
    func registerUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            } else if let result = result {
                UserDefaults.standard.set(result.user.uid, forKey: "userID")
                completion(nil)
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        //не нудно пролверять при логин
        if Auth.auth().currentUser == nil {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(error.localizedDescription)
                } else if let result = result {
                    UserDefaults.standard.set(result.user.uid, forKey: "userID")
                    completion(nil)
                }
            }
        } else {
            self.completion?()
        }
    }
    
    func sendSignInLink(email: String, password: String, completion: @escaping (String?) -> Void) async {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.url = URL(string: "")
        
        do {
            try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
        } catch {
            print(error.localizedDescription)
            completion(error.localizedDescription)
        }
    }
}
