//
//  InfoViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 13.04.25.
//

import Foundation

final class InfoViewModel {
    let section: [SettingsSections] = [.profile, .menu]
    
    func numberOfRows(in section: Int) -> Int {
        switch self.section[section] {
        case .profile:
            return 1
        case .menu:
            return 1
        }
    }
}
