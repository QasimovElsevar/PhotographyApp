//
//  TextFieldCell.swift
//  PhotographyApp
//
//  Created by Elsever on 03.04.25.
//

import UIKit

final class TextFieldCell: UICollectionViewCell {

    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false // Allows it to expand
        textView.backgroundColor = .profile
        textView.textColor = .white
        textView.textAlignment = .left
        return textView
    }()

    let placeholderLabel: UILabel = {
            let label = UILabel()
//            label.text = "Enter your text..."
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
        textView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .profile

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

extension TextFieldCell: UITextViewDelegate {

    internal func textViewDidBeginEditing(_ textView: UITextView) {
//        placeholderLabel.isHidden = true
        }

        // If empty after editing, reapply placeholder
    internal func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text == "" {
//            placeholderLabel.isHidden = false
//        }
        }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
//            let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
//            textView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
//        callback?()
        }
}
