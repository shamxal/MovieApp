//
//  MovieCell.swift
//  MovieAppProject
//
//  Created by Samxal Quliyev  on 10.07.24.
//

import UIKit

protocol TopImageBottomLabelProtocol {
    var imageName: String { get }
    var labelText: String { get }
}

class TopImageBottomLabelCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    func configure(data: TopImageBottomLabelProtocol) {
        movieNameLabel.text = data.labelText
        movieImage.loadURL(url: data.imageName)
    }
}
