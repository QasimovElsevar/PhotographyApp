//
//  FeedViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 12.04.25.
//

import UIKit

class FeedViewModel {
    
    var coordinator: MainCoordinator?
    var photoList: [Photos] = []
    var userData: UserModel?
    var page = 1
    
    let manager = FeedManager()
    
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
    
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            LayoutClass.createHorizontalDoubleCell()
        }
    }
    
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
    
    func getUserData() {
        FirestoreManager.shared.getUserData { [weak self] data, error in
            guard let self else {return}
            if let error = error {
                print(error)
            } else {
                userData = data
                UserDefaults.standard.set(data?.accessKey, forKey: "key")
            }
        }
    }
}
