//
//  FilterController.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.10.22.
//

import UIKit
import PanModal

class FilterController: UIViewController, Storyboarded {

    @IBOutlet private weak var table: UITableView!
    
    let viewModel = FilterViewModel()
    
    var selectionCallback: ((MovieCategory)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.registerCell(type: TableViewTitleCell.self)
    }
    
    
}

extension FilterController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewTitleCell = tableView.dequeueCell(for: indexPath)
        cell.configure(title: viewModel.items[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            self?.selectionCallback?(self?.viewModel.items[indexPath.row].type ?? .popular)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension FilterController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(312)
    }
}
