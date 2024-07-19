//
//  MovieMediaCell.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 18.07.24.
//

import UIKit

class MovieMediaCell: UICollectionViewCell, ReuseProtocol, NibProtocol {
    @IBOutlet private weak var mediaImage: UIImageView!
    @IBOutlet private weak var playButton: UIButton!

    var playActionCallback: (() -> Void)?
    
    func configure(mediaData: String) {
        mediaImage.loadURL(url: mediaData)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        playActionCallback?()
    }
}
