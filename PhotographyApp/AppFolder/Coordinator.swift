//
//  Coordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import Foundation
import UIKit

//protocol Coordinator {
//    func start ()
//   // func showFeedController()
//    func showSearchController()
//    func showUploadController()
//    func showLoginCOntroller()
//    func showProfileController()
//}

protocol Coordinator {
    var navigationController: UINavigationController {get}
    
    func start()
}
