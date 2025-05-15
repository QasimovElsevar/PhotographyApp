//
//  SettingsViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 02.04.25.
//

import UIKit

enum SettingsSections {
    case profile
    case menu
}

enum SettingsOptions: String {
    case profileediting = "Edit Profile"
    case changePassword = "Change Password"
    case account = "Account"
}

final class SettingsViewModel {
    let section: [SettingsSections] = [.profile, .menu]
    let options: [SettingsOptions] = [.profileediting, .changePassword, .account]
    var userData: UserModel
    let group = DispatchGroup()
    
    var selectedImage: [UIImage] = []
    
    init(userDara: UserModel) {
        self.userData = userDara
    }
    
    //MARK: - States
    
    enum ViewState {
        case profilePhotoAdded
        case success
        case error(String)
        case idle
    }
    
    var stateUpdate: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdate?(state)
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch self.section[section] {
        case .profile:
            return 1
        case .menu:
            return 3
        }
    }
    
    func changePasword() {
        FireBaseManager.shared.changePassword { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
            }
        }
    }
    
    func uploadImage() {
        StorageManager.shared.saveImage(images: selectedImage) { [weak self] id, url, error in
            guard let self else {return}
            if let error = error {
                state = .error(error)
            } else {
                
                let data: [String: Any] = ["profilePhoto": url ?? ""]
                
                FirestoreManager.shared.updateData(docName: userData.id ?? "", collectionType: .userDataCollection, updatedField: "profilePhoto", parameters: data, completion: { error in
                    if let error = error {
                        self.state = .error(error)
                    } else {
                        self.state = .profilePhotoAdded
                    }
                })
            }
        }
    }
}
