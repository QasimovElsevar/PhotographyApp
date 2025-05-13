//
//  AddToCollectionControllereCell.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import UIKit

final class CollectionsCell: UITableViewCell {

    //MARK: - UI Elements
    
    private lazy var image: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    private lazy var addButton : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(systemName: "plus.circle")
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Properties
    
    var callback: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Configure UI
    
    private func configureUI() {
        [image,
         titleLabel,
         subtitleLabel,
         addButton].forEach({addSubview($0)})
        backgroundColor = .settings
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 60),
            image.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(photo: [UsersPhotos], title: String, photoNum: Int, added: Bool) {
        if !photo.isEmpty {
            image.loadImage(with: photo[photo.endIndex - 1].url ?? "", and: photo[0].blurHash ?? "")
        }
            titleLabel.text = title
            subtitleLabel.text = "\(photoNum) photo"
        
        if added {
            addButton.image = UIImage(systemName: "checkmark.circle.fill")
            addButton.tintColor = .systemGreen
        } else {
            addButton.image = UIImage(systemName: "plus.circle")
            addButton.tintColor = .gray
        }
    }
}
