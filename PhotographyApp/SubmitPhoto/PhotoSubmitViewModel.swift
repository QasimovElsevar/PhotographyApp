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
    var builder = UsersPhotoBuilder()
    
    let id = UUID().uuidString
    var image: [UIImage]
    var pageControlCurrentPage: Int = 0
    var pageChanged: Bool = false
    
    init(image: [UIImage]) {
        self.image = image
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
        StorageManager.shared.saveImage(images: image) { [weak self] id, url, error in
            guard let self else {return}
            if let error = error {
                state = .error(error)
            } else {
                builder.set(id: id ?? "")
                builder.set(url: url ?? "")
                builder.set(createdAt: Date())
                let data = builder.build()
                
                FirestoreManager.shared.saveData(collectionType: .userPhotos, docName: "\(id ?? "") images", parameters: data) { error in
                    if let error = error {
                        print(error)
                    } else {
                        print("success")
                    }
                }
                self.state = .success
            }
        }
    }
}
