//
//  HorizontalMovieCell.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 02.10.22.
//

import UIKit
import SDWebImage

protocol MovieCellProtocol {
    var posterImage: String { get }
    var titleText: String { get }
    var ratingText: String { get }
}

class HorizontalMovieCell: UICollectionViewCell, ReuseProtocol, NibProtocol {
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var collection: UICollectionView!
    
    func configure(data: MovieCellProtocol) {
        titleLabel.text = data.titleText
        ratingLabel.text = data.ratingText
        movieImage.sd_setImage(with: URL(string: data.posterImage)!)
    }
}
