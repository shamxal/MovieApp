//
//  PeopleController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 02.10.22.
//

import UIKit

class PeopleController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = PeopleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        collection.registerCell(type: PeopleCell.self)
    }
    
    fileprivate func configureViewModel() {
        viewModel.getPopularPeople()
        viewModel.errorCallback = { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
        viewModel.successCallback = { [weak self] in
            self?.collection.reloadData()
        }
        viewModel.coordinator = PeopleCoordinator(navigationController: navigationController ?? UINavigationController())
    }
}

extension PeopleController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.peopleItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PeopleCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(data: viewModel.peopleItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.coordinator?.showPeopleMovies(id: viewModel.peopleItems[indexPath.item].id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10
        let height = collectionView.frame.height * 270 / 812
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}
