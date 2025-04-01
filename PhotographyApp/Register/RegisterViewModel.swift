//
//  RegisterViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 20.03.25.
//

import Foundation

class RegisterViewModel {
    
    let builder = UserBuilder()
    
    func InvalidMail(_ value: String) -> String? {
        let regExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        if !pred.evaluate(with: value) {
            return "Invalid email"
        }
        return nil
    }
    
    func InvalidPassword(_ value: String) -> String? {
        
        if value.count < 8
        {
            return "Password must be at least 8 characters"
        }
        if containsDigital(value)!
        {
            return "Password must contain at least one digit"
        }
        if containsLower(value)!
        {
            return "Password must contain at least one lowercase"
        }
        if containsUpper(value)!
        {
            return "Password must contain at least one uppercase"
        }
    
        return nil
    }
    
    func containsDigital(_ value: String) -> Bool? {
        let regExp = ".*[0-9]+.*"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        return !pred.evaluate(with: value)
    }
    func containsLower(_ value: String) -> Bool? {
        let regExp = ".*[a-z]+.*"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        return !pred.evaluate(with: value)
    }
    func containsUpper(_ value: String) -> Bool? {
        let regExp = ".*[A-Z]+.*"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        return !pred.evaluate(with: value)
    }
    
    func sendForAccessToken(completion: @escaping (PostForAccesKey?, String?) -> Void) {
        let params =  ["client_id": "x8sJp7pb7aDawfONcfXXuwkjGhCJecnUvbR-vZBQtC4",
                       "client_secret": "_QPLj1j_gQ7_D_HRcCM93VyLS15OKcWhGrfEFYZ3C94",
                       "redirect_uri": "urn:ietf:wg:oauth:2.0:oob",
                       "code": UserDefaults.standard.string(forKey: "code") ?? "",
                       "grant_type": "authorization_code"]
        let url = "https://unsplash.com/oauth/token"
        
        NetworkManager.shared.request(endPoint: url, model: PostForAccesKey.self, method: .post, params: params, completion: completion)
    }
    
    func saveData(completion: @escaping (String?) -> Void) {
        let data = builder.build()
        let firstname = data["firstname"] as! String
        let lastname = data["lastname"] as! String
        let username = data["username"] as! String
        let email = data["email"] as! String
        let authToken = data["authToken"] as! String
        
        FirestoreManager.shared.saveUser(firstName: firstname, lastName: lastname, username: username, email: email, accessKey: authToken, completion: completion)
    }
}
