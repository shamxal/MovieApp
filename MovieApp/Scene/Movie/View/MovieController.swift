//
//  MovieController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 18.11.22.
//

import UIKit

class MovieController: UIViewController {
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collection.bounces = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.registerCell(type: TitleCell.self)
        collection.registerCell(type: MoviInfoCell.self)
        collection.registerCell(type: MovieMediaCell.self)
        collection.registerCell(type: TopImageBottomLabelCell.self)
        return collection
    }()
    
    private var viewModel: MovieViewModel
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureViewModel()
        configureCompositionalLayout()
    }
    
    fileprivate func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    fileprivate func configureConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    fileprivate func configureViewModel() {
        viewModel.errorCallback = { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
        
        viewModel.successCallback = { [weak self] in
            self?.collection.reloadData()
        }
        
        viewModel.favoriteCallback = { [weak self] in
            guard let self else { return }
            navigationItem.rightBarButtonItem = nil
            let image = UIImage(systemName: viewModel.isFavoriteMovie ? "bookmark.fill" : "bookmark")
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addToWatchList))
        }
    }
    
    fileprivate func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env in
            switch self?.viewModel.dtoData[section].type {
            case .media:
                return MovieDetailLayout.mediaLayout(topHeight: self?.navigationBarHeight ?? 0)
            case .info:
                return MovieDetailLayout.infoLayout()
            case .overview:
                let data = (self?.viewModel.dtoData[section].data as? String) ?? ""
                let height = data.textHeight(data, width: self?.collection.frame.width ?? 0)
                return MovieDetailLayout.overviewLayout(height: height)
            case .title:
                return MovieDetailLayout.titleLayout()
            case .similarMovies:
                return MovieDetailLayout.similarMoviesLayout()
            default:
                return MovieDetailLayout.overviewLayout(height: 0)
            }
        }
        collection.setCollectionViewLayout(layout, animated: true)
    }
    
    @objc fileprivate func addToWatchList() {
        if viewModel.isFavoriteMovie {
            viewModel.removeFromFavorite()
        } else {
            viewModel.addMovieToFavorite()
        }
    }
}

extension MovieController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.dtoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.dtoData[section].type == .similarMovies {
            return viewModel.similarMovies.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = viewModel.dtoData[indexPath.section]
        switch data.type {
        case .media:
            if let posterImage = data.data as? String {
                let cell: MovieMediaCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(mediaData: posterImage)
                cell.playActionCallback = { [weak self] in
                    self?.viewModel.showVideList()
                }
                return cell
            }
            
        case .info:
            if let infoData = data.data as? MovieInfoData {
                let cell: MoviInfoCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(data: infoData)
                return cell
            }
            
        case .overview:
            if let text = data.data as? String {
                let cell: TitleCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(title: text, alingment: .left)
                return cell
            }
            
        case .title:
            if let title = data.data as? String {
                let cell: TitleCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(title: title, 
                               alingment: .left,
                               font: .systemFont(ofSize: 20, weight: .semibold))
                return cell
            }
            
        case .similarMovies:
            let cell: TopImageBottomLabelCell = collectionView.dequeueCell(for: indexPath)
            if let data = data.data as? [MovieResult] {
                cell.configure(data: data[indexPath.item])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.dtoData[indexPath.section].type == .media {
            viewModel.showVideList()
        } else if viewModel.dtoData[indexPath.section].type == .similarMovies {
            let id = viewModel.similarMovies[indexPath.item].id ?? 0
            let coordinator = MovieDetailCoordinator(movieId: id, navigationController: navigationController ?? UINavigationController())
            coordinator.start()
        }
    }
}
