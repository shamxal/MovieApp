//
//  PremiumCoordinator.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 31.07.24.
//

import UIKit
import RevenueCat
import RevenueCatUI

class PremiumCoordinator: Coordinator {
    var shouldPresent: Bool = true
    var navigationController: UINavigationController
    
    var lifetimeIdentifier = "com.lifetime.499"
    var paywallDidFinish: ((CustomerInfo) -> Void)?
    
    init(navigationController: UINavigationController,
         shouldPresent: Bool = true) {
        self.shouldPresent = shouldPresent
        self.navigationController = navigationController
    }
    
    func start() {
        let paywallController = PaywallViewController(offeringIdentifier: lifetimeIdentifier,
                                                      displayCloseButton: true)
        paywallController.delegate = self
        if shouldPresent {
            paywallController.modalPresentationStyle = .overFullScreen
            navigationController.present(paywallController, animated: true, completion: nil)
        } else {
            navigationController.show(paywallController, sender: nil)
        }
    }
    
    func restorePurchase(completion: @escaping((CustomerInfo?, String?) -> Void)) {
        Purchases.shared.restorePurchases { customerInfo, error in
            if let error {
                completion(nil, error.localizedDescription)
            } else if let customerInfo {
                completion(customerInfo, nil)
            }
        }
    }
    
    func presentCodeRedemptionSheet() {
        Purchases.shared.presentCodeRedemptionSheet()
    }
}

extension PremiumCoordinator: PaywallViewControllerDelegate {
    func paywallViewController(_ controller: PaywallViewController, didFinishPurchasingWith customerInfo: CustomerInfo) {
        UserDefaultsHelper.save(value: customerInfo.entitlements["Premium"]?.isActive == true ? PremiumType.yes.rawValue : PremiumType.no.rawValue,
                                       key: .premium)
        paywallDidFinish?(customerInfo)
    }
}
