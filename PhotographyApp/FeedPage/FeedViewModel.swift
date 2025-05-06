//
//  FeedViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 12.04.25.
//

import UIKit

final class FeedViewModel {
    
    //MARK: - Properties
    
    var coordinator: MainCoordinator?
    var photoList: [Photos] = []
    var userData: UserModel?
    var isLayoutChanged = false
    var page = 1
    
    let manager = FeedManager()
    
    //MARK: - State
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
    
    //MARK: - Collection Layout
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            if self.isLayoutChanged == false {
                FeedLayout.profileCollection()
            } else {
                FeedLayout.createHorizontalDoubleCell()
            }
        }
    }
    
    //MARK: - Data
    
    func getList() async {
        state = .loading
        do {
            let data =  try await manager.getList(page: page)
            Task {
                photoList.append(contentsOf: data)
                state = .success
                state = .loaded
                page += 1
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
                state = .loaded
            }
        }
    }
}
