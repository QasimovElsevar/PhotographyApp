//
//  UploadController.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit
import PhotosUI

final class UploadController: UIViewController {
    
    //  MARK: -UI Elements
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(UploadCell.self, forCellWithReuseIdentifier: "UploadCell")
        collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.register(TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var pickerViewController: PHPickerViewController = {
        var config = PHPickerConfiguration(photoLibrary:  PHPhotoLibrary.shared())
        config.selectionLimit = 9
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        return picker
    }()
    
    
    //MARK: - Properties
    
    let viewModel = UploadViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getData()
    }
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .myBackground
        addSubviews()
        setConstrains()
        bindViewModel()
        statusBarConfigure()
    }
    
    func addSubviews() {
        view.addSubview(collection)
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func statusBarConfigure() {
        view.createStatusBarCover(mainView: view)
        view.makeNavBarTransparent(navController: navigationController ?? UINavigationController())
        edgesForExtendedLayout = [.top]
    }
}

extension UploadController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Collection
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numOfCells(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .contributionText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Contribute to Unsplash", textSize: 20)
            return cell
        case .image:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as! UploadCell
            return cell
        case .topicText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Topics", textSize: 16)
            return cell
        case .topics:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TopicsCell", for: indexPath) as! TopicsCell
            cell.configure(url: viewModel.topics?[indexPath.row].coverPhoto?.urls?.thumb ?? "", topic: viewModel.topics?[indexPath.row].title ?? "")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.sections[indexPath.section] == .image {
            if FireBaseManager.shared.isUserSignedIn {
                let navController = UINavigationController(rootViewController: pickerViewController)
                navController.setNavigationBarHidden(true, animated: false)
                show(navController, sender: nil)
            } else {
                showAllert(title:"Failed", message: "Please Log in")
            }
        }
    }

}

extension UploadController: PHPickerViewControllerDelegate {
    
    //MARK: - Picker
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if results.isEmpty {
            dismiss(animated: true)
        } else {
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    viewModel.group.enter()
                    result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                        if let image = object as? UIImage {
                            self.viewModel.selectedImages.append(image)
                        }
                        self.viewModel.group.leave()
                    }
                    
                    result.itemProvider.loadDataRepresentation(forTypeIdentifier: "public.jpeg", completionHandler: { data, arg  in
                        if let data = data {
                               let src = CGImageSourceCreateWithData(data as CFData, nil)!
                               let d = CGImageSourceCopyPropertiesAtIndex(src,0,nil) as! [AnyHashable:Any]
                               print("metadata", d)
                           }
                    })
                }
            }
            viewModel.group.notify(queue: .main) {
                let coordinator = UploadCoordinator(navigationController: self.pickerViewController.navigationController ?? UINavigationController(), image: self.viewModel.selectedImages)
                coordinator.showSubmitController()
                self.viewModel.selectedImages.removeAll()
            }
        }
    }
}

extension UploadController {
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .success:
                    print("success")
                    collection.reloadData()
                case .error(let error):
                    print(error)
                case .idle:
                    break
                }
            }
        }
    }
}


