//
//  CollectionView+Extension.swift
//  UnimApp
//
//  Created by Shamkhal Guliyev on 17.09.21.
//

import UIKit

extension UITableView {
    func registerCell<T: NibProtocol & ReuseProtocol>(type: T.Type) {
        register(type.nib,
                 forCellReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueCell<T: ReuseProtocol>(for indexPath: IndexPath) -> T {
        let dequeued = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
        return dequeued
    }
}
