//
//  ProfileCollectionPhotosCell.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import UIKit

final class ProfileCollectionPhotosCell: UICollectionViewCell {
    
    private lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "Abraaakadabraa"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Configuration
    private func configureUI() {
        addSubview(imageView)
        imageView.addSubview(label)
        configure()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure() {
        imageView.image = UIImage(named: "testImage")
    }
}
