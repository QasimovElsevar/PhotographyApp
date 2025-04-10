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
    
    let sections: [Section] = [.browseText, .browse, .discoverText, .discover]
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
        case idle
    }
    
    var photoList: [Photos]?
    
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
                LayoutClass.createTextCell()
            case .browse:
                LayoutClass.createVerticalDoubleCell(groupWidth: 0.3)
            case .discoverText:
                LayoutClass.createTextCell()
            case .discover:
                LayoutClass.createHorizontalDoubleCell()
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
            photoList?.count ?? 0
        }
    }
    
    //MARK: - Data
    
    func getList() async {
        do {
            photoList = try await manager.getList()
            Task {
                state = .success
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
}
