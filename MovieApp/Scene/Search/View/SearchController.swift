//
//  SearchController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 02.10.22.
//

import UIKit

class SearchController: UIViewController {
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchIcon: UITextField!
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        collection.registerCell(type: HorizontalMovieCell.self)
        searchIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchIconTap)))
    }
    
    fileprivate func configureViewModel() {
        viewModel.errorCallback = { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
        viewModel.successCallback = { [weak self] in
            self?.collection.reloadData()
        }
    }
    
    @objc fileprivate func searchIconTap() {
        searchTextField.becomeFirstResponder()
    }
    
    @IBAction func searchTextFieldAction(_ sender: Any) {
        if !(searchTextField.text?.isEmpty ?? false) {
            viewModel.search(text: searchTextField.text ?? "")
            collection.reloadData()
        }
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalMovieCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(data: viewModel.movieItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel.movieItems[indexPath.item].id else { return }
        let coordinator = MovieDetailCoordinator(movieId: id,
                                                 navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 360 / 375, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty ?? false {
            viewModel.resetDatas()
            collection.reloadData()
        }
        textField.resignFirstResponder()
        return true
    }
}
