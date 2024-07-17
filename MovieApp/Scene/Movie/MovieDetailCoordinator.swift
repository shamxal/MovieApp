//
//  MovieDetailCoordinator.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 18.07.24.
//

import UIKit
import Foundation

class MovieDetailCoordinator: Coordinator {
    var movieId: Int
    var navigationController: UINavigationController
    
    init(movieId: Int, navigationController: UINavigationController) {
        self.movieId = movieId
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = MovieController(viewModel: .init(movieId: movieId, coordinator: self))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
}
