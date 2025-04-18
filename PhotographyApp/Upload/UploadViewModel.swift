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
}

final class UploadViewModel {
    
    //MARK: - Sections
    var coordinator: MainCoordinator?
    let sections: [Sections] = [.contributionText, .image, .topicText, .topics]
    
    enum ViewState {
        case success
        case error(String)
        case idle
    }
    
    //MARK: -  Properties
    let manager = UploadManager()
    var topics: [Topics]?
    
    var stateUpdate: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdate?(state)
        }
    }
    
    //MARK: -  Collection related
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .image:
                UploadLayout.createUploadCell()
            case .topicText, .contributionText:
                UploadLayout.CreateTextSizeLayout()
            case .topics:
                UploadLayout.createVerticalDoubleCell()
            }
        }
    }
    
    func numOfCells (section: Int) -> Int {
        switch sections[section] {
        case .image, .topicText, .contributionText:
            1
        case .topics:
            topics?.count ?? 0
        }
    }
    
    //MARK: -  Data
    func getData() {
        manager.getData { [weak self] array, error in
            guard let self else {return}
            
            if let error = error {
                state = .error(error)
            } else {
                topics = array
                state = .success
            }
        }
    }
}
