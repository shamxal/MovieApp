//
//  HomeHeader.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 16.10.22.
//

import UIKit

class HomeHeader: UICollectionReusableView, ReuseProtocol, NibProtocol {
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var collection: UICollectionView!
    @IBOutlet private weak var viewBottom: UIView!
    
    func configure() {
        
    }
}

extension HomeHeader: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}
