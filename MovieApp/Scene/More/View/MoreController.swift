//
//  MoreController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 19.10.22.
//

import UIKit

class MoreController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = MoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.registerCell(type: MoreCell.self)
    }
}

extension MoreController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MoreCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(title: viewModel.items[indexPath.item].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 60)
    }
}
