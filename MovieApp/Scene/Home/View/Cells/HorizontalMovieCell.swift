//
//  HorizontalMovieCell.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 02.10.22.
//

import UIKit

class HorizontalMovieCell: UICollectionViewCell, ReuseProtocol, NibProtocol {
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
