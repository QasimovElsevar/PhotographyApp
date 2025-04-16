//
//  UploadViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import Foundation
import UIKit

enum Sections {
    case contributionText
    case image
    case topicText
    case topics
    case blogText
    case blog
}

final class UploadViewModel {
    
    // Sections
    var coordinator: MainCoordinator?
    let sections: [Sections] = [.contributionText, .image, .topicText, .topics, .blogText, .blog]
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error
        case idle
    }
    
    // Properties
    let manager = UploadManager()
    var topics: [Topics]?
    
    var success: (() -> Void)?
    var failure: ((String) -> Void)?
    var stateUpdate: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdate?(state)
        }
    }
    
    // Collection related
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .image:
                UploadLayout.createUploadCell()
            case .topicText, .blogText, .contributionText:
                UploadLayout.CreateTextSizeLayout()
            case .topics:
                UploadLayout.createVerticalDoubleCell()
            case .blog:
                UploadLayout.createLatestFromBlogCell()
            }
        }
    }
    
    func numOfCells (section: Int) -> Int {
        switch sections[section] {
        case .image, .topicText, .blogText, .contributionText:
            1
        case .topics:
            topics?.count ?? 0
        case .blog:
            10
        }
    }
    
    // Data
    func getData() {
        state = .loading
        manager.getData { [weak self] array, error in
            guard let self else {return}
            
            if let error = error {
                failure?(error)
                state = .loaded
            } else {
                topics = array
                success?()
                state = .loaded
            }
        }
    }
}
