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
        viewModel.errorCallback = { [weak self] message in
            self?.present(AlertViewHelper.showAlert(message: message), animated: true)
        }
        
        viewModel.successCallback = { [weak self] in
            self?.collection.reloadData()
        }
    }
    
    fileprivate func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env in
            switch self.viewModel.dtoData[section].type {
            case .media:
                return MovieDetailLayout.mediaLayout(topHeight: self?.navigationBarHeight ?? 0)
            case .info:
                return MovieDetailLayout.infoLayout()
            case .overview:
                return MovieDetailLayout.overviewLayout()
            default:
                return MovieDetailLayout.overviewLayout()
            }
        }
        collection.setCollectionViewLayout(layout, animated: true)
    }
}

extension MovieController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.dtoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = viewModel.dtoData[indexPath.section]
        switch data.type {
        case .media:
            if let posterImage = data.data as? String {
                let cell: MovieMediaCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(mediaData: posterImage)
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
        }
        return UICollectionViewCell()
    }
}
