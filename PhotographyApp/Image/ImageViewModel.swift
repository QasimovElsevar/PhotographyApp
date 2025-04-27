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
    var count = 0
    
    var photoId: String
    var isLiked = false
    
    init(photoId: String) {
        self.photoId = photoId
    }
    
    //MARK: - State
    
    enum ViewState {
        case saved
        case couldNotSave
        case liked
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
                if self.photoResultArray.isEmpty {
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
            if self.photoResultArray.isEmpty {
                1
            } else {
                photoResultArray.count
            }
        }
    }
    
    //MARK: Data
    
    func getPhoto() async  {
        do {
            let photo =  try await manager.getPhoto(id: photoId)
            Task {
                self.photo = photo
                isLiked = photo.likedByUser ?? false
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
    
    func getRelatedPhotos() async {
        do {
            let photoArrayFirstTag = try await manager.getRelatedPhotos(query: photo?.tags?[count].title ?? "")
            Task {
                photoResultArray.append(contentsOf: photoArrayFirstTag.results ?? [])
                count += 1
                state = .success
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func likePhoto() async {
        do {
            let _ = try await manager.likePhoto(id: photoId)
            Task {
                state = .liked
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func unlikePhoto() async {
        do {
            let _ = try await manager.unlikePhoto(id: photoId)
            Task {
                state = .unliked
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func saveLikedPhoto() {
        FirestoreManager.shared.saveUsersLikedPhotos(photoUrl: photo?.urls?.regular ?? "", authorsName: photo?.user?.name ?? "", photoId: photo?.id ?? "", blurHash: photo?.blurHash ?? "") { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .couldNotSave
            }
        }
    }
    
    func deleteUnlikedPhoto() {
        FirestoreManager.shared.deleteUsersUnlikedPhoto(photoId: photoId) { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .couldNotSave
            }
        }
    }
//    func addPhotoToCollection() async {
//        do {
//            try await manager.addPhotoToCollection(id: photoId, collectionId: <#T##String#>)
//        }
//    }
//    
//    func saveToLibrary(_ image: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
//    }
//    
//    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error:
//    Error?, contextInfo: UnsafeRawPointer) {
//        print("Saved")
//    }
    
}
