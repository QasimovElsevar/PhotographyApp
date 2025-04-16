//
//  SearchViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 26.03.25.
//

import Foundation
import UIKit

enum Section {
    case browseText
    case browse
    case discoverText
    case discover
}

class SearchViewModel {
    var coordinator: MainCoordinator?

    let sections: [Section] = [.browseText, .browse, .discoverText, .discover]
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
        case idle
    }
    
    var photoList: [Photos] = []
    var page = 1
    
    let manager = SearchManager()
    
    var stateUpdate: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdate?(state)
        }
    }
    
    //MARK: - UI configuration
        
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .browseText:
                SearchLayout.CreateTextSizeLayout()
            case .browse:
                SearchLayout.createVerticalDoubleCell()
            case .discoverText:
                SearchLayout.CreateTextSizeLayout()
            case .discover:
                SearchLayout.createHorizontalDoubleCell()
            }
        }
    }
    
    func numberOfSections(index: Int) -> Int {
        switch sections[index] {
        case .browseText, .discoverText:
            1
        case .browse:
        10
        case .discover:
            photoList.count 
        }
    }
    
    //MARK: - Data
    
    func getList() async {
        do {
            let data =  try await manager.getList(page: page)
            Task {
                photoList.append(contentsOf: data)
                state = .success
                page += 1
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
}
