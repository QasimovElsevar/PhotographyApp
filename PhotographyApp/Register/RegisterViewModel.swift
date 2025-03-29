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
    
}
