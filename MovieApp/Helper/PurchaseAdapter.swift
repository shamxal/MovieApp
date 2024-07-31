//
//  PurchaseAdapter.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 31.07.24.
//

import UIKit
import RevenueCat
import RevenueCatUI

class PurchaseAdapter {
    static let shared = PurchaseAdapter()
    
    var paywallDidFinish: ((CustomerInfo) -> Void)?
    
    func presentPaywall(controller: UIViewController, shouldPresent: Bool = true) {
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

extension PurchaseAdapter: PaywallViewControllerDelegate {
    func paywallViewController(_ controller: PaywallViewController, didFinishPurchasingWith customerInfo: CustomerInfo) {
        UserDefaultsHelper.save(value: customerInfo.entitlements["Premium"]?.isActive == true ? PremiumType.yes.rawValue : PremiumType.no.rawValue,
                                       key: .premium)
        paywallDidFinish?(customerInfo)
    }
}
