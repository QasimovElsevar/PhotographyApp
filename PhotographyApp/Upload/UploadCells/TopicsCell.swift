//
//  TopicsCell.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import UIKit

final class TopicsCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    private lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "photo")
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var darkerView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifcycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Configure
    
    private func configureUI() {
        layer.cornerRadius = 12
        addSubviews()
        setCnstraints()
    }
    
    private func addSubviews() {
        addSubview(imageView)
        [darkerView,
         label].forEach({imageView.addSubview($0)})
    }
    
    private func setCnstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            darkerView.topAnchor.constraint(equalTo: imageView.topAnchor),
            darkerView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            darkerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            darkerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8)
        ])
    }
    
    //MARK: - Sent Data
    
    func configure(url: String, topic: String) {
        imageView.loadImage(url: url)
        label.text = topic
    }
}
