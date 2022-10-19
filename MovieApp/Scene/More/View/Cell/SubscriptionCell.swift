//
//  SubscriptionCell.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 19.10.22.
//

import UIKit

class SubscriptionCell: UICollectionViewCell, ReuseProtocol, NibProtocol {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 1
                layer.borderColor = UIColor.blue.cgColor
            }
        }
    }
}
