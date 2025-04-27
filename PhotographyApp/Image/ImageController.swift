//
//  ImageController.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import UIKit

class ImageController: UIViewController {

    //MARK: - UI Elements
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.register(ImageWithLabelCell.self, forCellWithReuseIdentifier: "ImageWithLabelCell")
        collection.register(TransparentViewCell.self, forCellWithReuseIdentifier: "TransparentViewCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var likeBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLike))
        view.addGestureRecognizer(tapGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addToCollectionBackgrounfView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(
                handleAddingToCollection
            )
        )
        view.addGestureRecognizer(tapGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var downloadBackgrounfView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDownload))
        view.addGestureRecognizer(tapGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "heart.fill")
        image.clipsToBounds = true
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var addToCollectionImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(systemName: "plus")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var downloadImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(systemName: "arrow.down")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var infoButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal) 
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Properties
    
    let viewModel: ImageViewModel
    
    init(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lyfcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navBarTitleConfigure()
    }
    
    //MARK: - UI Configure
    private func configureUI() {
        view.backgroundColor = .myBackground
        addSubviews()
        setConstraints()
        statusBarConfigure()
        bindViewModel()
        configureNavBar()
    }
    
    private func addSubviews() {
        [imageView,
         collection,
         likeBackgroundView,
         addToCollectionBackgrounfView,
         downloadBackgrounfView,
         infoButton].forEach( {view.addSubview($0)})
        
        likeBackgroundView.addSubview(likeImage)
        addToCollectionBackgrounfView.addSubview(addToCollectionImage)
        downloadBackgrounfView.addSubview(downloadImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            likeBackgroundView.bottomAnchor.constraint(equalTo: addToCollectionBackgrounfView.topAnchor, constant: -20),
            likeBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            likeBackgroundView.widthAnchor.constraint(equalToConstant: 40),
            likeBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            addToCollectionBackgrounfView.bottomAnchor.constraint(equalTo: downloadBackgrounfView.topAnchor, constant: -20),
            addToCollectionBackgrounfView.heightAnchor.constraint(equalToConstant: 40),
            addToCollectionBackgrounfView.widthAnchor.constraint(equalToConstant: 40),
            addToCollectionBackgrounfView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            downloadBackgrounfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            downloadBackgrounfView.heightAnchor.constraint(equalToConstant: 40),
            downloadBackgrounfView.widthAnchor.constraint(equalToConstant: 40),
            downloadBackgrounfView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            likeImage.centerXAnchor.constraint(equalTo: likeBackgroundView.centerXAnchor),
            likeImage.heightAnchor.constraint(equalToConstant: 20),
            likeImage.widthAnchor.constraint(equalToConstant: 20),
            likeImage.centerYAnchor.constraint(equalTo: likeBackgroundView.centerYAnchor),
            
            addToCollectionImage.centerXAnchor.constraint(equalTo: addToCollectionBackgrounfView.centerXAnchor),
            addToCollectionImage.heightAnchor.constraint(equalToConstant: 20),
            addToCollectionImage.widthAnchor.constraint(equalToConstant: 20),
            addToCollectionImage.centerYAnchor.constraint(equalTo: addToCollectionBackgrounfView.centerYAnchor),
            
            downloadImage.centerXAnchor.constraint(equalTo: downloadBackgrounfView.centerXAnchor),
            downloadImage.heightAnchor.constraint(equalToConstant: 20),
            downloadImage.widthAnchor.constraint(equalToConstant: 20),
            downloadImage.centerYAnchor.constraint(equalTo: downloadBackgrounfView.centerYAnchor),
            
            infoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            infoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12)
            
        ])
    }
    
    private func imageConfigure() {
        if viewModel.photo?.likedByUser ?? false {
            likeImage.tintColor = .red
        } else {
            likeImage.tintColor = .white
        }
    }
    
    func statusBarConfigure() {
        view.createStatusBarCover(mainView: view)
        view.makeNavBarTransparent(navController: navigationController ?? UINavigationController())
        edgesForExtendedLayout = [.top]
    }
}

extension ImageController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Collection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(sections: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .mainPhoto:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TransparentViewCell", for: indexPath) as! TransparentViewCell
            cell.configure(text: "")
            return cell
        case .relatedPhotos:
            if viewModel.photoResultArray.isEmpty {
                let cell = collection.dequeueReusableCell(withReuseIdentifier: "TransparentViewCell", for: indexPath) as! TransparentViewCell
                cell.configure(text: "No related photos")
                return cell
            } else {
                let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
                let photos = viewModel.photoResultArray[indexPath.row]
                cell.configure(data: photos.urls?.regular ?? "" , text: photos.user?.name ?? "", blurHash: photos.blurHash ?? "")
                return cell
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let coordinator = FeedCoordinator(navigationController: navigationController ?? UINavigationController(), id: viewModel.photoResultArray[indexPath.row].id ?? "")
            coordinator.showImageController()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 1 && viewModel.count < viewModel.photo?.tags?.count ?? 0 && indexPath.row == viewModel.photoResultArray.count - 2 {
            Task {
                await viewModel.getRelatedPhotos()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        changeAlpha(scrollView: scrollView)
    }
}

extension ImageController {
    //MARK: ViewModel Binding
    
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .saved:
                    print("saved")
                case .couldNotSave:
                    print("not saved")
                case .liked:
                    likeImage.tintColor = .red
                case  .unliked:
                    likeImage.tintColor = .white
                case .success:
                    print("success")
                    collection.reloadData()
                    imageConfigure()
                    imageView.loadImage(with: viewModel.photo?.urls?.regular ?? "", and: viewModel.photo?.blurHash ?? "")
                    navigationItem.title = viewModel.photo?.user?.name ?? ""
                case .error(let error):
                    print(error)
                case .idle:
                    break
                }
            }
        }
    }
    
    func getData() {
        Task {
            await viewModel.getPhoto()
        }
    }
    
    //MARK: - Button Actions
    
    @objc private func handleLike() {
        Task {
            if viewModel.isLiked {
                await viewModel.unlikePhoto()
                viewModel.deleteUnlikedPhoto()
                viewModel.isLiked = false
            } else {
                await viewModel.likePhoto()
                viewModel.saveLikedPhoto()
                viewModel.isLiked = true
            }
        }
    }
    
    @objc private func handleDownload() {
        savePhotoToLibrary()
    }
    
    @objc private func handleAddingToCollection() {
        let coordinator = FeedCoordinator(navigationController: navigationController ?? UINavigationController(), id: viewModel.photoId)
        coordinator.showAddToCollectionController()
    }
    
    @objc private func handleInfo() {
    
    }
    
    private func changeAlpha(scrollView: UIScrollView) {
        imageView.alpha = 1 - scrollView.contentOffset.y / (view.frame.height / 1.5)
        likeBackgroundView.alpha = 1 - scrollView.contentOffset.y / (view.frame.height / 1.5)
        addToCollectionBackgrounfView.alpha = 1 - scrollView.contentOffset.y / (view.frame.height / 1.5)
        downloadBackgrounfView.alpha = 1 - scrollView.contentOffset.y / (view.frame.height / 1.5)
        infoButton.alpha = 1 - scrollView.contentOffset.y / (view.frame.height / 1.5)
    }
    
    func savePhotoToLibrary() {
        let saver = ImageSaver()
        saver.writeToPhotoAlbum(image: imageView.image ?? UIImage())
        
        saver.success = {
            UIView.transition(with: self.downloadImage, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.downloadImage.image = UIImage(systemName: "checkmark")
            })
        }
        
        saver.failure = { error in
            self.showAllert(title: "Error", message: "Couldn`t save image")
        }
    }
    
    //MARK: - NavigationBa Configure
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(handleShare))
    }
    
    private func navBarTitleConfigure() {
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]
    }
    
    //MARK: - BarButton Action
    
    @objc func handleShare() {
        let items = [URL(string: viewModel.photo?.urls?.regular ?? "")]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc private func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
}
