//
//  PhotoSubmitCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 03.04.25.
//

import Foundation
import UIKit

final class PhotoSubmitCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = PhotoSubmitController()
        navigationController.show(controller, sender: nil)
    }
    
    
}
