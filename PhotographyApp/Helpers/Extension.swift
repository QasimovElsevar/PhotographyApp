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
    
    func loadImage(with data: String, and blurHash: String, UsersPhotos: Bool = false) {
        if !UsersPhotos {
            let url = URL(string: data)
            let bluredImage = UIImage(blurHash: blurHash, size: CGSize(width: 32, height: 32), punch: 1)
            
            if let image = UIImage(named: data) {
                self.image = image
            } else {
                kf.setImage(with: url, placeholder: bluredImage)
            }
        } else {
            StorageManager.shared.downloadImage(url: data, completion: { [weak self] image, error  in
                if let error = error {
                    print(error)
                } else {
                    self?.image = image
                }
            })
        }
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

extension Notification.Name {
    static let webViewDismissed = Notification.Name("webViewDismissed")
}

extension UIView {
    func createStatusBarCover(mainView: UIView) {
        var _: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: mainView.frame.width, height: 100))
            view.backgroundColor = .myBackground
            view.alpha = 1
            view.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(view)
            return view
        }()
    }
    
    func makeNavBarTransparent(navController: UINavigationController) {
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.backgroundColor = .none
    }
}
