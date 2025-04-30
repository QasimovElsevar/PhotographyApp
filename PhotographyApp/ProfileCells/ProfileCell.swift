//
//  ProfileCell.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import UIKit

final class ProfileCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    private lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.fill")
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
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
    
    //MARK: - Lifcycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI Configure
    
    func configureUI() {
        backgroundColor = .profile
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        [label,
        imageView
        ].forEach( {addSubview($0)} )
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
        ])
    }
    
    //MARK: - Cell Data
    func configure(username: String) {
        label.text = "\(username)"
    }
}
