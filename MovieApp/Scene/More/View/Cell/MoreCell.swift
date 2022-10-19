//
//  MoreCell.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 19.10.22.
//

import UIKit

class MoreCell: UICollectionViewCell, ReuseProtocol, NibProtocol {

    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
