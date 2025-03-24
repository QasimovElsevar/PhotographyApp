//
//  LatestBlogCell.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import UIKit

class LatestBlogCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "photo")
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var title : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Behind 1 Billion"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var author : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Elsevar Qasimov"
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
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
    
    private func configureUI() {
        [imageView,
         title,
         author].forEach{addSubview($0)}
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: frame.height - title.frame.height + author.frame.height + 8),
            imageView.widthAnchor.constraint(equalToConstant: frame.width),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            author.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
