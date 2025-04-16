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
                return PhotoSubmitLayout.CreateTextSizeLayout()
            case .description:
                return PhotoSubmitLayout.selectionCell(height: 150)
            case .locationText:
                return PhotoSubmitLayout.CreateTextSizeLayout()
            case .location:
                return PhotoSubmitLayout.selectionCell(height: 45)
            case .tagsText:
                return PhotoSubmitLayout.CreateTextSizeLayout()
            case .tags:
                return PhotoSubmitLayout.selectionCell(height: 45)
            }
        }
    }
}
