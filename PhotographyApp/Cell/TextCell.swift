//
//  TextCell.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

class TextCell: UICollectionViewCell {
    private lazy var title : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Submit to topics"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
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
    
    func configureUI() {
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        ])
    }
}
