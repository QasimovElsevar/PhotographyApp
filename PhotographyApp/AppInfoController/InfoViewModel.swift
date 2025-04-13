//
//  InfoViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 13.04.25.
//

import Foundation

//enum SettingsOptions: String {
//    case profileediting = "Edit Profile"
//    case changePassword = "Change Password"
//    case account = "Account"
//}

final class InfoViewModel {
    let section: [SettingsSections] = [.profile, .menu]
//    let options: [SettingsOptions] = [.profileediting, .changePassword, .account]
    
    func numberOfRows(in section: Int) -> Int {
        switch self.section[section] {
        case .profile:
            return 1
        case .menu:
            return 1
        }
    }
}
