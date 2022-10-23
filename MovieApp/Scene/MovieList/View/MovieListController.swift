//
//  MovieListController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.10.22.
//

import UIKit

class MovieListController: UIViewController {

    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        collection.registerCell(type: HorizontalMovieCell.self)
    }
    
    fileprivate func configureViewModel() {
        
    }
}

extension MovieListController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalMovieCell = collectionView.dequeueCell(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 327 / 375, height: 120)
    }
}
