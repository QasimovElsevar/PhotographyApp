//
//  ImageViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import UIKit

enum PhotoSections {
    case mainPhoto
    case relatedPhotos
}

class ImageViewModel {
    
    //MARK: Properties
    
    let manager = ImageManager()
    
    let sections: [PhotoSections] = [.mainPhoto, .relatedPhotos]
    var searchPhoto: Search?
    var photoResultArray = [Result]()
    var photo: PhotoDetails?
    
    var photoId: String
    var isLiked = false
    
    init(photoId: String) {
        self.photoId = photoId
    }
    
    //MARK: - State
    
    enum ViewState {
        case liked
        case unlike
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
    
    //MARK: collection Layout
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .mainPhoto:
                ImageLayout.wholeScreen()
            case .relatedPhotos:
                ImageLayout.createHorizontalDoubleCell()
            }

        }
    }
    
    func numberOfItems(sections: Int) -> Int {
        switch self.sections[sections] {
        case .mainPhoto:
            1
        case .relatedPhotos:
            photoResultArray.count 
        }
    }
    
    //MARK: Data
    
    func getPhoto() async  {
        do {
            let photo =  try await manager.getPhoto(id: photoId)
            Task {
                self.photo = photo
                state = .success
                await getRelatedPhotos()
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func getRelatedPhotos() async {
        do {
            let photoArrayFirstTag = try await manager.getRelatedPhotos(query: photo?.tags?[0].title ?? "")
            let photoArraySecondTag = try await manager.getRelatedPhotos(query: photo?.tags?[1].title ?? "")
            let photoArrayThirdTag = try await manager.getRelatedPhotos(query: photo?.tags?[2].title ?? "")
            Task {
                photoResultArray.append(contentsOf: photoArrayFirstTag.results ?? [])
                photoResultArray.append(contentsOf: photoArraySecondTag.results ?? [])
                photoResultArray.append(contentsOf: photoArrayThirdTag.results ?? [])
                photoResultArray.shuffle()
                state = .success
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func likePhoto() async{
        do {
            let likedPhoto = try await manager.likePhoto(id: photoId)
            Task {
                state = .liked
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
}
