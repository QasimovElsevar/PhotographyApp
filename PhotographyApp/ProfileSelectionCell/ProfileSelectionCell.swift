//
//  ProfileSelectionCell.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import UIKit

final class ProfileSelectionCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    private lazy var selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .selectionView
        view.layer.cornerRadius = 8
        view.backgroundColor = .selectionView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .selectedView
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photos: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Photos"
        label.textColor = .label
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tag = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeSelection))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var likes: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Likes"
        label.numberOfLines = 0
        label.textColor = .label
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = 1
        label.textAlignment = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeSelection))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var collections: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Collections"
        label.numberOfLines = 0
        label.textColor = .label
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = 2
        label.textAlignment = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeSelection))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    //MARK: - Properties
    private var leftConstraint = NSLayoutConstraint()
    
    let viewModel = ProfileSelectionViewModel()
    
    var callback: ((Int) -> Void)?
    var tagNumber = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure UI
    
    func configureUI() {
       addSubview(selectionView)
        [selectedView,
         photos,
         likes,
         collections
        ].forEach( { selectionView.addSubview($0) } )
        
        leftConstraint = selectedView.leadingAnchor.constraint(equalTo: selectionView.leadingAnchor, constant: 2)
        
        NSLayoutConstraint.activate([
            selectionView.topAnchor.constraint(equalTo: topAnchor),
            selectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            leftConstraint,
            selectedView.widthAnchor.constraint(equalToConstant: frame.width / 3 - 4),
            selectedView.heightAnchor.constraint(equalToConstant: frame.height - 4),
            selectedView.centerYAnchor.constraint(equalTo: selectionView.centerYAnchor),
            
            photos.leadingAnchor.constraint(equalTo: selectionView.leadingAnchor),
            photos.widthAnchor.constraint(equalToConstant: frame.width / 3),
            photos.centerYAnchor.constraint(equalTo: selectionView.centerYAnchor),
            
            likes.leadingAnchor.constraint(equalTo: photos.trailingAnchor),
            likes.widthAnchor.constraint(equalToConstant: frame.width / 3),
            likes.centerYAnchor.constraint(equalTo: selectionView.centerYAnchor),
            
            collections.leadingAnchor.constraint(equalTo: likes.trailingAnchor),
            collections.widthAnchor.constraint(equalToConstant: frame.width / 3),
            collections.centerYAnchor.constraint(equalTo: selectionView.centerYAnchor),

        ])
    }
    
    //MARK: Actions
    
    @objc func changeSelection(_ sender: UITapGestureRecognizer) {
        
        if let label = sender.view as? UILabel {
            tagNumber = label.tag
            callback?(tagNumber)
        }
        
        DispatchQueue.main.async {
            self.animationChange()
        }
    }
    
    func animationChange() {
        switch viewModel.selections[tagNumber] {
        case .photos:
            UIView.animate(withDuration: 0.2) {
                self.leftConstraint.constant = 0
                self.layoutIfNeeded()
            }
        case .likes:
            UIView.animate(withDuration: 0.2) {
                self.leftConstraint.constant = self.frame.width / 3
                self.layoutIfNeeded()
            }
        case .collections:
            UIView.animate(withDuration: 0.2) {
                self.leftConstraint.constant = (self.frame.width / 3) * 2
                self.layoutIfNeeded()
            }
        }
    }
}
