//
//  extension.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import Foundation
import UIKit
import Kingfisher

extension UITextField {

    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: 1.0)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIImageView {
    
    func loadImage(url: String) {
        let urlPrefix = "\(NetworkManager().imageUrl)\(url)"
        let url = URL(string: "\(urlPrefix)")
        self.kf.setImage(with: url)
    }
}
