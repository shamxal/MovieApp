//
//  HomeController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionSetup()
        viewModelConfiguration()
    }
    
    fileprivate func collectionSetup() {
        collection.registerCell(type: HorizontalMovieCell.self)
    }
    
    fileprivate func viewModelConfiguration() {
        viewModel.getGenreItems()
        viewModel.errorCallback = { [weak self] errorMessage in
            print("error: \(errorMessage)")
        }
        viewModel.successCallback = { [weak self] in
            self?.collection.reloadData()
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalMovieCell = collectionView.dequeueCell(for: indexPath)
//        print(viewModel.movie?.results?[indexPath.item].originalTitle ?? "")
        if let movie = viewModel.movie?.results?[indexPath.item] {
            cell.configure(data: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 327 / 375, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 365)
    }
}
