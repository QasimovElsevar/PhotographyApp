//
//  WebViewMOdel.swift
//  PhotographyApp
//
//  Created by Elsever on 29.03.25.
//

import Foundation
import UIKit

class WebViewModel {
    
    let builder: UserBuilder

    init (builder: UserBuilder) {
        self.builder = builder
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
    
    func cutURL(url: String) -> String {
        let urlArray = url.split(separator: "=")
        return String(urlArray[1])
    }
}
