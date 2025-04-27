//
//  AddToCollectionControllereCell.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import UIKit

class AddToCollectionControllereCell: UITableViewCell {

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
    

    
    private lazy var addButton : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(systemName: "plus.circle")
        image.tintColor = .gray
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAdd))
        image.addGestureRecognizer(tapGesture)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
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
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 4),
            
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            addButton.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func configure(photo: [PreviewPhoto], title: String, photoNum: Int) {
        image.loadImage(with: photo[0].urls?.small ?? "", and: photo[0].urls?.small ?? "")
        titleLabel.text = title
        subtitleLabel.text = "\(photoNum) photo"
    }
    
    @objc private  func handleAdd() {
        callback?()
        print("add")
    }

}
