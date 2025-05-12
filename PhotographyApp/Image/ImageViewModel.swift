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
    var userLiked: [UsersPhotos] = []
    var userPhoto: [UsersPhotos]?
    var photoResultArray = [Result]()
    var photo: PhotoDetails?
    var userPhotos = false
    var isLiked = false
    var urlToCall = ""
    var count = 0
    
    var photoId: String
    
    init(photoId: String) {
        self.photoId = photoId
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
        FirestoreManager.shared.getADocument(collectionType: .userPhotos, id: photoId, model: UsersPhotos.self) { photo, error in
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
    
//    func likePhoto() async {
//        do {
//            let _ = try await manager.likePhoto(id: photoId)
//            Task {
//                state = .liked
//            }
//        } catch {
//            Task {
//                state = .error(error.localizedDescription)
//            }
//        }
//    }
//    
//    func unlikePhoto() async {
//        do {
//            let _ = try await manager.unlikePhoto(id: photoId)
//            Task {
//                state = .unliked
//            }
//        } catch {
//            Task {
//                state = .error(error.localizedDescription)
//            }
//        }
//    }
    
//    func saveLikedPhoto() {
//        FirestoreManager.shared.saveUsersLikedPhotos(photoUrl: photo?.urls?.regular ?? "", authorsName: photo?.user?.name ?? "", photoId: photo?.id ?? "", blurHash: photo?.blurHash ?? "") { error in
//            if let error = error {
//                self.state = .error(error)
//            } else {
//                self.state = .couldNotSave
//            }
//        }
//    }
    
    func saveLikedPhoto() {
        
        let parameter: [String: Any] = [
            "url": photo?.urls?.regular ?? "",
            "author": photo?.user?.name ?? "",
            "id": photoId,
            "blurHash": photo?.blurHash ?? "",
            "createdAt": Date()
        ]
        
        FirestoreManager.shared.saveData(collectionType: .likedPhotoCollection, docName: photoId, parameters: parameter) { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .liked
            }
        }
    }
    
    func deleteUnlikedPhoto() {
        FirestoreManager.shared.deleteDocument(collectionType: .likedPhotoCollection, docName: photoId) { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .unliked
            }
        }
    }
    
    func getUsersLikedPhotos() {
        FirestoreManager.shared.getData(collectionType: .likedPhotoCollection, model: UsersPhotos.self) { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.userLiked = data ?? []
                self.imageConfigure()
                self.state = .success
            }
        }
    }
    
    private func imageConfigure() {
        if userLiked.contains(where: { $0.id == photoId }) {
            isLiked = true
        } else {
            isLiked = false
        }
    }
    
    func deletePhoto() {
        FirestoreManager.shared.deleteDocument(collectionType: .userPhotos, docName: "\(userPhoto?[0].id ?? "") images") { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .deleted
            }
        }
    }
    
//    func updateData() async {
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
