//
//  WebCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 28.03.25.
//

import Foundation
import UIKit

final class WebCoordinator: Coordinator2 {
    var navigationController: UINavigationController
    var viewModel: WebViewModel
    
    init(navigationController: UINavigationController, viewModel: WebViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let controller = WebController(viweModel: viewModel)
        navigationController.present(controller, animated: true)
    }
}

