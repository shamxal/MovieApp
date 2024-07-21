//
//  MovieVideoCell.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 21.07.24.
//

import UIKit
import YouTubeiOSPlayerHelper

class MovieVideoCell: UICollectionViewCell, NibProtocol, ReuseProtocol {
    @IBOutlet private weak var playerView: YTPlayerView!
    
    func configure(videoId: String) {
        playerView.load(withVideoId: videoId)
    }
}
