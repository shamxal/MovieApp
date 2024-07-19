//
//  MoviInfoCell.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 19.07.24.
//

import UIKit

class MoviInfoCell: UICollectionViewCell, ReuseProtocol, NibProtocol {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var collection: UICollectionView!
    
    var genres = [String]()
    
    override func layoutSubviews() {
        collection.registerCell(type: LabelCollectionCell.self)
    }
    
    func configure(data: MovieInfoData) {
        titleLabel.text = data.title
        durationLabel.text = data.duration
        ratingLabel.text = data.rating
        releaseDateLabel.text = data.releaseDate
        
        genres = data.genre
        collection.reloadData()
    }
}

extension MoviInfoCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LabelCollectionCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(text: genres[indexPath.item].uppercased())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: collectionView.frame.height)
    }
}
