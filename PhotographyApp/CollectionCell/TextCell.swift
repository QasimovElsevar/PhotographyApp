//
//  TextCell.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

final class TextCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    private lazy var title : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Submit to topics"
        label.font = .systemFont(ofSize: 16, weight: .bold)
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
    
    //MARK: - UI Configuration
    
    func configureUI() {
        addSubview(title)
        setContraints()
    }
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        ])
    }
    
    func configure(text: String, textSize: CGFloat) {
        title.text = text
        title.font = .systemFont(ofSize: textSize, weight: .bold)
    }
}
