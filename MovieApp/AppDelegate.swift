//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }


}

