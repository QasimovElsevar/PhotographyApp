//
//  PhotoSubmitViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 03.04.25.
//

import Foundation
import UIKit
import FirebaseStorage

enum PhotoSubmitSections {
    case selectedPhotos
    case description
    case descriptionText
    case pageControl
    case location
    case locationText
    case tags
    case tagsText
}

final class PhotoSubmitViewModel {
    
    let sections: [PhotoSubmitSections] = [.selectedPhotos, .pageControl, .descriptionText, .description, .locationText, .location, .tagsText, .tags]
    
    let manager = PhotoSubmitManager()
    
    let id = UUID().uuidString
    var image: [UIImage]
    var pageControlCurrentPage: Int = 0
    var pageChanged: Bool = false
    
    init(image: [UIImage]) {
        self.image = image
    }
    
    //MARK: - States
    
    enum ViewState {
        case loading
        case loaded
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
    
    func numberOfitems(index: Int) -> Int {
        switch sections[index] {
        case .descriptionText, .description, .locationText, .location, .tagsText, .tags, .pageControl:
            1
        case .selectedPhotos:
            image.count
        }
    }
    
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .selectedPhotos:
                return PhotoSubmitLayout.selectionCell(height: 250)
            case .descriptionText, .locationText, .tagsText, .pageControl:
                return PhotoSubmitLayout.CreateTextSizeLayout()
            case .description:
                return PhotoSubmitLayout.selectionCell(height: 150)
            case .location, .tags:
                return PhotoSubmitLayout.selectionCell(height: 45)
            }
        }
    }
    
    func uploadImage() {
        StorageManager.shared.saveImage(images: image) { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
            }
        }
    }
}
