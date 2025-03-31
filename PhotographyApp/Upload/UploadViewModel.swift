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
    case topicText
    case topics
    case blogText
    case blog
}

class UploadViewModel {
    
    // Sections
    let sections: [Sections] = [.image, .topicText, .topics, .blogText, .blog]
    
    // Properties
    let manager = UploadManager()
    var topics: [Topics]?
    
    var success: (() -> Void)?
    var failure: ((String) -> Void)?
    
    // Collection related
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .image:
                UploadLayout.createUploadCell()
            case .topicText:
                LayoutClass.createTextCell()
            case .topics:
                LayoutClass.createVerticalDoubleCell(groupWidth: 0.4)
            case .blog:
                UploadLayout.createLatestFromBlogCell()
            case .blogText:
                LayoutClass.createTextCell()
            }
        }
    }
    
    func numOfCells (section: Int) -> Int {
        switch sections[section] {
        case .image, .topicText, .blogText:
            1
        case .topics:
            10
        case .blog:
            10
        }
    }
    
    // Data
    func getData() {
        manager.getData { [weak self] array, error in
            if let error = error {
                self?.failure?(error)
            } else {
                self?.topics = array
                self?.success?()
            }
        }
    }
}
