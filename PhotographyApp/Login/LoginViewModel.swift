//
//  LoginViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 30.03.25.
//

import Foundation

final class LoginViewModel {
    
    var userInfo: UserModel?
    var coordinator: MainCoordinator?
    
    func InvalidMail(_ value: String) -> String? {
        let regExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        if !pred.evaluate(with: value) {
            return "Invalid email"
        }
        return nil
    }
}
