//
//  TableViewTitleCell.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.10.22.
//

import UIKit

class TableViewTitleCell: UITableViewCell, NibProtocol, ReuseProtocol {

    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
