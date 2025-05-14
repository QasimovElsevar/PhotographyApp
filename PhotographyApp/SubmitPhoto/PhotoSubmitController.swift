//
//  PhotoSubmitController.swift
//  PhotographyApp
//
//  Created by Elsever on 03.04.25.
//

import UIKit

final class PhotoSubmitController: UIViewController {

    //MARK: -UI Elements
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.keyboardDismissMode = .onDrag
        collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.register(TextFieldCell.self, forCellWithReuseIdentifier: "TextFieldCell")
        collection.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collection.register(PageControlCell.self, forCellWithReuseIdentifier: "PageControlCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
      let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    //MARK: - Properties
    let viewModel: PhotoSubmitViewModel
    
    init(viewModel: PhotoSubmitViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .myBackground
        view.addSubview(collection)
        view.addSubview(pageControl)
        setConstraints()
        navigationBarConfigure()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func navigationBarConfigure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Review Images"
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        configureNavRightButton()
    }
}

extension PhotoSubmitController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfitems(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .selectedPhotos:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            cell.configure(image: viewModel.image[indexPath.row])
            return cell
        case .descriptionText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Description", textSize: 16)
            return cell
        case .locationText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Location", textSize: 16)
            return cell
        case .tagsText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Tags", textSize: 16)
            return cell
        case .description:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Add Description")
            cell.callback = { description in
                self.viewModel.builder.set(description: description)
            }
            return cell
        case .location:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Add Location")
            cell.callback = { location in
                self.viewModel.builder.set(location: location)
            }
            return cell
        case .tags:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Add Tags")
            cell.callback = { tags in
                self.viewModel.builder.set(tags: tags)
            }
            return cell
        case .pageControl:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "PageControlCell", for: indexPath) as! PageControlCell
            cell.configure(numberOfPages: viewModel.image.count, currentPage: viewModel.pageControlCurrentPage)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print(indexPath.row)
            viewModel.pageControlCurrentPage = indexPath.row
            collection.reloadData()
        }
    }
}

extension PhotoSubmitController {
    
    //MARK: - NavBar Actions
    
    @objc func handleCancel() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSubmit() {
        viewModel.uploadImage()
    }
    
    func configureNavRightButton() {
        let boldFont = UIFont.boldSystemFont(ofSize: 17)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont
        ]

        let rightButton = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
        rightButton.setTitleTextAttributes(attributes, for: .normal)

        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .success:
                    showAllert(title: "Success", message: "Photos are uploaded") { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                case .error(let error):
                    showAllert(title: "Failure", message: error)
                case .idle:
                    break
                }
            }
        }
    }
}
