//
//  SettingsViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 02.04.25.
//

import Foundation

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
    var userDara: UserModel
    
    init(userDara: UserModel) {
        self.userDara = userDara
    }
    
    //MARK: - States
    
    enum ViewState {
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
}
