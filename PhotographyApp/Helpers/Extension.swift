//
//  extension.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: String) {
        let urlPrefix = "\(NetworkManager().imageUrl)\(url)"
        let url = URL(string: "\(urlPrefix)")
        self.kf.setImage(with: url)
    }
}

extension UIViewController {
    func showAllert(title: String = "Error", message: String? = nil, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
                   self.present(alertController, animated: true, completion: nil)
               }
    }
}
