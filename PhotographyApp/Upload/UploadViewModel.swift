//
//  UploadViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import Foundation
import UIKit

enum Sections {
    case image
    case text
}

class UploadViewModel {
    let sections: [Sections] = [.image, .text]
    
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .image:
                UploadLayout.createUploadCell()
            case .text:
                UploadLayout.createTextCell()
            }
        }
    }
    
    func numOfCells (section: Int) -> Int {
        switch sections[section] {
        case .image, .text:
            1
        }
    }
}
