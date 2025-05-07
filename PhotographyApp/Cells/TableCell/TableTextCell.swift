//
//  TableTextCell.swift
//  PhotographyApp
//
//  Created by Elsever on 04.04.25.
//

import UIKit

final class TableTextCell: UITableViewCell {

    private lazy var label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
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
        accessoryType = .disclosureIndicator
    }

    private func configureUI() {
        backgroundColor = .selectionView
        addSubview(label)
        
        NSLayoutConstraint.activate ([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(settingOptions: String) {
        label.text = settingOptions
    }
}
