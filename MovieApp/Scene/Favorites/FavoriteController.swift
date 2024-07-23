//
//  FavoriteController.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 23.07.24.
//

import UIKit

class FavoriteController: UIViewController {
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.bounces = true
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.registerCell(type: HorizontalMovieCell.self)
        return collection
    }()
    
    private let viewModel = FavoriteViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraint()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        navigationItem.title = "Favorite Movies"
        view.backgroundColor = .systemBackground
        collection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    fileprivate func configureConstraint() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    fileprivate func configureViewModel() {
        viewModel.getFavoriteItems()
        viewModel.errorCallback = { [weak self] message in
            self?.refreshControl.endRefreshing()
            self?.present(AlertViewHelper.showAlert(message: message), animated: true)
        }
        
        viewModel.successCallback = { [weak self] in
            self?.collection.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc fileprivate func refresh() {
        viewModel.getFavoriteItems()
    }
}

extension FavoriteController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalMovieCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(data: viewModel.items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinator = MovieDetailCoordinator(movieId: viewModel.items[indexPath.item].movieId ?? 0,
                                                 navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width * 0.92, height: 120)
    }
}
