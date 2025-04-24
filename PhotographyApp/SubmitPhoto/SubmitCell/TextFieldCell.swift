//
//  TextFieldCell.swift
//  PhotographyApp
//
//  Created by Elsever on 03.04.25.
//

import UIKit

final class TextFieldCell: UICollectionViewCell, UITextViewDelegate {
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .profile
        textView.textColor = .white
        textView.delegate = self
        textView.textAlignment = .left
        return textView
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 0
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var text: String = ""
    var callback: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .profile
        layer.cornerRadius = 20
        addSubview(textView)
        textView.addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 4),
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 12)
        ])
    }
    
    func configure(placeholder: String) {
        placeholderLabel.text = placeholder
    }
}
