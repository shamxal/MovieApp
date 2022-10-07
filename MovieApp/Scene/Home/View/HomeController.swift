//
//  HomeController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionSetup()
    }
    
    fileprivate func collectionSetup() {
        collection.registerCell(type: HorizontalMovieCell.self)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalMovieCell = collectionView.dequeueCell(for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 365)
    }
}
