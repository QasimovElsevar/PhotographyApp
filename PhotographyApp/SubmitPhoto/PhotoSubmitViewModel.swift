//
//  PhotoSubmitViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 03.04.25.
//

import Foundation
import UIKit

enum PhotoSubmitSections {
    case selectedPhotos
    case description
    case descriptionText
    case location
    case locationText
    case tags
    case tagsText
}

final class PhotoSubmitViewModel {
    
    let sections: [PhotoSubmitSections] = [.selectedPhotos, .descriptionText, .description, .locationText, .location, .tagsText, .tags]
    
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .selectedPhotos:
                return PhotoSubmitLayout.selectionCell(height: 250)
            case .descriptionText:
                return LayoutClass.createTextCell()
            case .description:
                return PhotoSubmitLayout.selectionCell(height: 150)
            case .locationText:
                return LayoutClass.createTextCell()
            case .location:
                return PhotoSubmitLayout.selectionCell(height: 45)
            case .tagsText:
                return LayoutClass.createTextCell()
            case .tags:
                return PhotoSubmitLayout.selectionCell(height: 45)
            }
        }
    }
}
