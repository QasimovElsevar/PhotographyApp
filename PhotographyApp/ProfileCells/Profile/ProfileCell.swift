//
//  ProfileCell.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    private lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.fill")
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .label
        label.text = "fsdacdsa"
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
    
    func configureUI() {
        [
            label,
            imageView
        ].forEach( {addSubview($0)} )
        
        backgroundColor = .profile
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
//            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(firstName: String, lastName: String) {
        label.text = "\(firstName) \(lastName)"
    }
    
}
