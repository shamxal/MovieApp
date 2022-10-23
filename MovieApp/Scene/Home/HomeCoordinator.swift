//
//  HomeCoordinator.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var filterSelection: ((MovieCategory)->())?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showMovieDetail(movieId: Int) {
        
    }
    
    func showFilter() {
        let controller = FilterController.instantiate(name: .main)
        controller.selectionCallback = { [weak self] category in
            self?.filterSelection?(category)
        }
        navigationController.presentPanModal(controller)
    }
}
