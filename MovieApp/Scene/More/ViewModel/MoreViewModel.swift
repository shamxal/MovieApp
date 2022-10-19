//
//  MoreViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 19.10.22.
//

import Foundation

class MoreViewModel {
    var coordinator: MoreCoordinator?
    
    let items = [MoreModel(title: "About Us", type: .aboutUs),
                 MoreModel(title: "Subscription", type: .subscription),
//                 MoreModel(title: "Dark Mode", type: .darkMode),
                 MoreModel(title: "Privacy Policy", type: .privacyPolicy),
                 MoreModel(title: "Terms of Use", type: .termsOfUse)]
    
    init(coordinator: MoreCoordinator) {
        self.coordinator = coordinator
    }        
}
