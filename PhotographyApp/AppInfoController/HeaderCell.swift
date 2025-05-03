//
//  HeaderCell.swift
//  PhotographyApp
//
//  Created by Elsever on 03.05.25.
//

import UIKit

class HeaderCell: UITableViewCell {

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "logo")
        image.backgroundColor = .selectionView
        image.tintColor = .white
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .placeholder
        label.text = "Photography App"
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
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 4),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
