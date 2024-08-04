//
//  HomeController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    @IBOutlet private weak var premiumButton: UIBarButtonItem!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewModel()
        configureUI()
    }
    
    fileprivate func configureUI() {
        if !UserDefaultsHelper.get(key: .premium) {
            viewModel.coordinator?.showPremiumPage()
        }
        collection.registerCell(type: HorizontalMovieCell.self)
        collection.registerSupplementaryView(type: HomeHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    fileprivate func configureViewModel() {
        viewModel.coordinator = HomeCoordinator(navigationController: navigationController ?? UINavigationController())
        viewModel.getGenreItems()
        viewModel.getNowPlaying()
        viewModel.errorCallback = { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
        viewModel.successCallback = { [weak self] in
            self?.collection.reloadData()
        }
        viewModel.coordinator?.filterSelection = { [weak self] category in
            self?.viewModel.movieCategory = category
            self?.viewModel.movieItems.removeAll()
            self?.viewModel.getCategorItems()
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        viewModel.coordinator?.showFilter()
    }
    
    
    @IBAction func premiumButtonTapped(_ sender: Any) {
        viewModel.coordinator?.showPremiumPage()
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalMovieCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(data: viewModel.movieItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: HomeHeader = collectionView.dequeueSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        header.configure(data: viewModel.nowPlayingItems)
        header.didItemSelected = { [weak self] id in
            self?.viewModel.coordinator?.showMovieDetail(id: id)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.coordinator?.showMovieDetail(id: viewModel.movieItems[indexPath.item].id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 327 / 375, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 365)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}
