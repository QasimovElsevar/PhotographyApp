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

final class ImageViewModel {
    
    //MARK: Properties
    
    let manager = ImageManager()
    
    let sections: [PhotoSections] = [.mainPhoto, .relatedPhotos]
    var userLikedPhotos: [UsersPhotos] = []
    var userPhoto: [UsersPhotos]?
    var photo: PhotoDetails?
    var relatedPhotos = [Result]()
    var isUsersPhotos: Bool?
    var isLiked = false
    var urlToCall = ""
    var count = 0
    
    var photoId: String
    
    init(photoId: String, userPhotos: Bool? = false) {
        self.photoId = photoId
        self.isUsersPhotos = userPhotos
    }
    
    //MARK: - State
    
    enum ViewState {
        case liked
        case deleted
        case unliked
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
                if self.relatedPhotos.isEmpty {
                    ImageLayout.wholeScreen()
                } else {
                    ImageLayout.createHorizontalDoubleCell()
                }
            }
        }
    }
    
    func numberOfItems(sections: Int) -> Int {
        switch self.sections[sections] {
        case .mainPhoto:
            1
        case .relatedPhotos:
            if self.relatedPhotos.isEmpty {
                1
            } else {
                relatedPhotos.count
            }
        }
    }
    
    //MARK: Data
    
    //Photos
    func getPhoto() async  {
        do {
            let photo =  try await manager.getPhoto(id: photoId)
            Task {
                self.photo = photo
                urlToCall = photo.urls?.regular ?? ""
                state = .success
                if !(photo.tags?.isEmpty ?? true) {
                    await getRelatedPhotos()
                }
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func getAPhoto() {
        manager.getAPhoto(id: photoId) {photo, error in
            if let error = error {
                self.state = .error(error)
            } else {
                if !(photo?.isEmpty ?? true) {
                    self.userPhoto = photo
                    self.urlToCall = photo?[0].url ?? ""
                    self.state = .success
                }
            }
        }
    }
    
    func deletePhoto() {
        manager.deletePhoto(id:  userPhoto?[0].id ?? "") { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .deleted
            }
        }
    }
    
    //Related Photos
    
    func getRelatedPhotos() async {
        do {
            let photoArrayFirstTag = try await manager.getRelatedPhotos(query: photo?.tags?[count].title ?? "")
            Task {
                relatedPhotos.append(contentsOf: photoArrayFirstTag.results ?? [])
                count += 1
                state = .success
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    //Liked Photos
    
    func saveLikedPhoto() {
        
        let parameter: [String: Any] = [
            "url": photo?.urls?.regular ?? "",
            "author": photo?.user?.name ?? "",
            "id": photoId,
            "blurHash": photo?.blurHash ?? "",
            "createdAt": Date()
        ]
        
        manager.likePhoto(id: photoId, parameter: parameter) { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .liked
            }
        }
    }
    
    func deleteUnlikedPhoto() {
        manager.unlikePhoto(id: photoId) {error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .unliked
            }
        }
    }
    
    func getUsersLikedPhotos() {
        manager.checkLike { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.userLikedPhotos = data ?? []
                self.imageConfigure()
                self.state = .success
            }
        }
    }
    
    //Liked Photo Check
    
    private func imageConfigure() {
        if userLikedPhotos.contains(where: { $0.id == photoId }) {
            isLiked = true
        } else {
            isLiked = false
        }
    }
}
