//
//  WebCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 28.03.25.
//

import Foundation
import UIKit

class WebCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = WebController()
        controller.show(controller, sender: nil)
    }
    
    
}
