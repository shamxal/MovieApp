//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit
import FirebaseCore
import RevenueCat

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var number = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Constants.apiKeyRevenueCat)
        Purchases.shared.delegate = self
        
        Purchases.shared.getCustomerInfo { customerInfo, _ in
            guard let customerInfo else { return }
            UserDefaultsHelper.save(value: customerInfo.entitlements[Constants.entitlementIdRevenueCat]?.isActive == true ? PremiumType.yes.rawValue : PremiumType.no.rawValue,
                                    key: .premium)
        }
        
        return true
    }


}

extension AppDelegate: PurchasesDelegate {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        print("Modified")
    }
}
