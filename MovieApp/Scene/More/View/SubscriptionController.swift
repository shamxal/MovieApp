//
//  SubscriptionController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 19.10.22.
//

import UIKit
import PanModal

class SubscriptionController: UIViewController, Storyboarded {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!
    
    let viewModel = SubscriptionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    fileprivate func configureUI() {
        collection.registerCell(type: TitleCell.self)
        collection.registerCell(type: SubscriptionCell.self)
        continueButton.layer.borderWidth = 1
        continueButton.layer.borderColor = UIColor.getColor(color: .borderColor)?.cgColor
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
    }
}

extension SubscriptionController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 2 {
            let cell: TitleCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(title: viewModel.descriptionText)
            return cell
        }
        let cell: SubscriptionCell = collectionView.dequeueCell(for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if indexPath.item == 2 {
            return CGSize(width: width, height: TitleCell.textHeight(viewModel.descriptionText, width: width))
        }
        return CGSize(width: width, height: 250)
    }
}

extension SubscriptionController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        .maxHeight
    }
    
    var cornerRadius: CGFloat {
        16
    }
}
