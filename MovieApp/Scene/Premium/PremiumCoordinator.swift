//
//  PremiumCoordinator.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 31.07.24.
//

import UIKit
import RevenueCat
import RevenueCatUI

class PremiumCoordinator {//: Coordinator {
    
//    var navigationController: UINavigationController
    
//    var paywallDidFinish: ((CustomerInfo) -> Void)?
    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
    
    static let shared = PremiumCoordinator()
    
    func start(controller: UIViewController) {
        let paywallController = PaywallViewController(offeringIdentifier: Constants.lifetimeIdentifier, displayCloseButton: true)
        paywallController.delegate = self
        paywallController.modalPresentationStyle = .overFullScreen
        controller.present(paywallController, animated: true, completion: nil)
//        navigationController.present(paywallController, animated: true, completion: nil)
//        navigationController.presentDebugRevenueCatOverlay()
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
    func paywallViewControllerDidStartPurchase(_ controller: PaywallViewController) {
        print("paywallViewControllerDidStartPurchase")
    }
    
    func paywallViewController(_ controller: PaywallViewController, didFinishPurchasingWith customerInfo: CustomerInfo) {
        UserDefaultsHelper.save(value: customerInfo.entitlements[Constants.entitlementIdRevenueCat]?.isActive == true ? PremiumType.yes.rawValue : PremiumType.no.rawValue,
                                key: .premium)
//        paywallDidFinish?(customerInfo)
    }
    
    func paywallViewControllerDidCancelPurchase(_ controller: PaywallViewController) {
        print("paywallViewControllerDidCancelPurchase")
    }
    
    func paywallViewControllerWasDismissed(_ controller: PaywallViewController) {
        print("paywallViewControllerWasDismissed")
    }
    
    func paywallViewControllerDidStartRestore(_ controller: PaywallViewController) {
        print("paywallViewControllerDidStartRestore")
    }
}
