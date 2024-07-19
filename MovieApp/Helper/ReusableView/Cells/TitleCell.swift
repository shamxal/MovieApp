//
//  TitleCell.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 21.10.22.
//

import UIKit

class TitleCell: UICollectionViewCell, ReuseProtocol, NibProtocol {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(title: String, alingment: NSTextAlignment = .center) {
        titleLabel.text = title
    }
}
