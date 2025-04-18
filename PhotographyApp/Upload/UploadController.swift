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
        var config = PHPickerConfiguration()
        config.selectionLimit = 9
        let picker = PHPickerViewController(configuration: config)
        //        picker.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
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
}

extension UploadController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Collection
    
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
            cell.configure(text: "Submit to topics", textSize: 16)
            return cell
        case .topics:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TopicsCell", for: indexPath) as! TopicsCell
            cell.configure(url: viewModel.topics?[indexPath.row].coverPhoto?.urls?.thumb ?? "", topic: viewModel.topics?[indexPath.row].title ?? "")
            return cell
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            4
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if viewModel.sections[indexPath.section] == .image {
                //            var config = PHPickerConfiguration()
                //            config.selectionLimit = 9
                //
                //            let picker = PHPickerViewController(configuration: config)
                //            picker.delegate = self
                //            picker.modalPresentationStyle = .fullScreen
                //            pickerViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss))
                present(pickerViewController, animated: true)
            }
        }
    }
}

extension UploadController: PHPickerViewControllerDelegate {
    
    //MARK: - Picker
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let selectedImage = results.first?.itemProvider {
            dismiss(animated: true) {
                selectedImage.registeredTypeIdentifiers.forEach { print($0) }
                let coordinator = MainCoordinator(navigationController: self.navigationController ?? UINavigationController())
                coordinator.showSubmitController()
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            dismiss(animated: true) {
                let coordinator = MainCoordinator(navigationController: self.navigationController ?? UINavigationController())
                coordinator.showSubmitController()
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
                case .error:
                    print("error")
                case .idle:
                    break
                }
            }
        }
    }
}


