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
            print(errorMessage)
        }
        viewModel.successCallback = { [weak self] in
            self?.collection.reloadData()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10
        let height = collectionView.frame.height * 270 / 812
        return CGSize(width: width, height: height)
    }
}
