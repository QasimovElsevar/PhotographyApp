//
//  ProfileEditingViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 22.04.25.
//

import Foundation

final class ProfileEditingViewModel {
    
    var userArray: UserModel
    
    init(userArray: UserModel) {
        self.userArray = userArray
    }
    
    
    func updateUser() {
//        FirestoreManager.shared.updateUserData(firstName: userArray.firstName ?? "", lastName: userArray.lastName ?? "", username: userArray.username ?? "", email: userArray.email ?? "", accessKey: userArray.accessKey ?? "") { error in
//            if let error = error {
//                print(error)
//            }
//        }
    }
}
