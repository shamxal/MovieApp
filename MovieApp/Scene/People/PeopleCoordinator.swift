//
//  PeopleCoordinator.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.10.22.
//

import Foundation
import UIKit

class PeopleCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showPeopleMovies(id: Int) {
        let controller = MovieListController.instantiate(name: .main)
        controller.viewModel = MovieListViewModel(id: id, type: .person)
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
}
