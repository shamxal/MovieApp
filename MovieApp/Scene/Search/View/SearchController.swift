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
            print(errorMessage)
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
            viewModel.getItems(text: searchTextField.text ?? "")
        }
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.item?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalMovieCell = collectionView.dequeueCell(for: indexPath)
        if let movie = viewModel.item?.results?[indexPath.item] {
            cell.configure(data: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 360 / 375, height: 120)
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty ?? false {
            viewModel.item = nil
            collection.reloadData()
        }
        textField.resignFirstResponder()
        return true
    }
}
