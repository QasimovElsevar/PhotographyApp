//
//  MyCollections.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

final class MyCollectionsCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    private lazy var firstPreviewImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .selectionView
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var secondPreviewImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .selectionView
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var thirdPreviewImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .selectionView
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fillEqually
        [
            firstPreviewImage,
            secondPreviewImage,
            thirdPreviewImage
        ].forEach {stack.addArrangedSubview($0)}
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Properties
    
    var count = 0
    
    //MARK: - Lifcycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure UI
    
    private func configureUI() {
        backgroundColor = .profile
        layer.cornerRadius = 10
        addSubview(stack)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.heightAnchor.constraint(equalToConstant: frame.height * 0.6),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configure(photos: [UsersPhotos], itemCount: Int, name: String) {
        for item in 0..<photos.count {
            if item == 0 {
                firstPreviewImage.loadImage(with: photos[item].url ?? "", and: photos[item].blurHash ?? "")
            } else if item == 1 {
                secondPreviewImage.loadImage(with: photos[item].url ?? "", and: photos[item].blurHash ?? "")
            } else if item == 2 {
                thirdPreviewImage.loadImage(with: photos[item].url ?? "", and: photos[item].blurHash ?? "")
            }
        }
        titleLabel.text = name
        subtitleLabel.text = "\(itemCount) photos"
    }
}
