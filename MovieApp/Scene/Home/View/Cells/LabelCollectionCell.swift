//
//  LabelCollectionCell.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import UIKit

class LabelCollectionCell: UICollectionViewCell, ReuseProtocol, NibProtocol {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(text: String) {
        titleLabel.text = text
    }
}
