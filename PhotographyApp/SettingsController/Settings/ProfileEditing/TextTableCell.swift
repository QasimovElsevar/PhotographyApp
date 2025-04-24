//
//  TextTableCell.swift
//  PhotographyApp
//
//  Created by Elsever on 22.04.25.
//

import UIKit

class TextTabelCell: UITableViewCell {

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func configureUI() {
        backgroundColor = .selectionView
        addSubview(textField)
        
        NSLayoutConstraint.activate ([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func conbfigure(text: String) {
        textField.text = text
    }
}
