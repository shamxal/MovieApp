//
//  MovieListController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.10.22.
//

import UIKit

class MovieListController: UIViewController, Storyboarded {
    @IBOutlet private weak var collection: UICollectionView!
    
    var viewModel: MovieListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        title = "Movie List"
        collection.registerCell(type: HorizontalMovieCell.self)
    }
    
    fileprivate func configureViewModel() {
        viewModel?.errorCallback = { message in
            print("error: \(message)")
        }
        
        viewModel?.successCallback = { [weak self] in
            self?.collection.reloadData()
        }
    }
}

extension MovieListController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalMovieCell = collectionView.dequeueCell(for: indexPath)
        if let item = viewModel?.items[indexPath.item] {
            cell.configure(data: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinator = MovieDetailCoordinator(movieId: viewModel?.items[indexPath.item].id ?? 0,
                                                 navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
