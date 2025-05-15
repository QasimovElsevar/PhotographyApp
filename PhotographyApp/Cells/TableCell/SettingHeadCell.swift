//
//  SettingHeadCell.swift
//  PhotographyApp
//
//  Created by Elsever on 02.04.25.
//

import UIKit

final class SettingHeadCell: UITableViewCell {

    //MARK: -UI Elements
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.backgroundColor = .selectionView
        image.tintColor = .white
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .systemBlue
        label.text = "Edit profile photo"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI() {
        backgroundColor = .selectionView
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(image)
        addSubview(label)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func configure(imageUrl: String) {
        image.loadImage(with: imageUrl, and: "", UsersPhotos: true)
    }
}
