//
//  VerticalMovieCell.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 16.10.22.
//

import UIKit

class VerticalMovieCell: UICollectionViewCell, ReuseProtocol, NibProtocol {
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    func configure(data: MovieCellProtocol) {
        titleLabel.text = data.titleText
        ratingLabel.text = data.ratingText
        movieImage.loadURL(url: data.posterImage)
    }
}
