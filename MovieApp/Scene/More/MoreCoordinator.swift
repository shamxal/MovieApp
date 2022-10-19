//
//  MoreCoordinator.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 19.10.22.
//

import Foundation
import UIKit
import PanModal

class MoreCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showSubscription() {
        let controller = SubscriptionController.instantiate(name: .main)
        navigationController.presentPanModal(controller)
    }
}
