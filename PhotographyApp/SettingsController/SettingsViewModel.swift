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

class SettingsViewModel {
    let section: [SettingsSections] = [.profile, .menu]
    
    func numberOfRows(in section: Int) -> Int {
        switch self.section[section] {
        case .profile:
            return 1
        case .menu:
            return 3
        }
    }
}
