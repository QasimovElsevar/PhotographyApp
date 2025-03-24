//
//  LoginAdapter.swift
//  PhotographyApp
//
//  Created by Elsever on 22.03.25.
//

import Foundation

import Foundation
import GoogleSignIn
import FirebaseCore

class LoginAdapter {

    enum ViewState {
        case loading
        case error(String)
        case success(LoggedUser)
    }
    
    var completion: ((ViewState) -> Void)?
    
    func loginWithGoogle(from viewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn( withPresenting: viewController ) { [weak self] user, error in
            if let error = error {
                self?.completion?(.error(error.localizedDescription))
            } else {
                self?.completion?(.success(LoggedUser(name: user?.user.profile?.name ?? "", email: user?.user.profile?.email ?? "")))
            }
        }
    }
}
