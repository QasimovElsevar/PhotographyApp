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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(handleEditProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 2
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .leading
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(editProfileButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var callback: (() -> Void)?
    
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
        [imageView,
         stack
        ].forEach( {addSubview($0)} )
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
        ])
    }
    
    //MARK: - Cell Data
    func configure(username: String) {
        label.text = "\(username)"
    }
    
    @objc private func handleEditProfile() {
        callback?()
    }
}
