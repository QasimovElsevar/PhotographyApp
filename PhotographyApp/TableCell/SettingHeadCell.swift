//
//  SettingHeadCell.swift
//  PhotographyApp
//
//  Created by Elsever on 02.04.25.
//

import UIKit

class SettingHeadCell: UITableViewCell {

    private lazy var image: UIImageView = {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureUI() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(image)
        addSubview(label)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
