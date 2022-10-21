//
//  CollectionView+Extension.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit

let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
let font = UIFont(name: Fonts.FontNames.regular.rawValue, size: 12)!

extension UICollectionView {
    func registerCell<T: NibProtocol & ReuseProtocol>(type: T.Type) {
        register(type.nib,
                 forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerSupplementaryView<T: NibProtocol & ReuseProtocol>(type: T.Type, ofKind kind: String) {

        register(type.nib,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: type.reuseIdentifier
        )
    }

    func dequeueSupplementaryView<T: ReuseProtocol>(ofKind kind: String, for indexPath: IndexPath) -> T {

        let dequeued = dequeueReusableSupplementaryView(ofKind: kind,
                                                        withReuseIdentifier: T.reuseIdentifier,
                                                        for: indexPath) as! T
        return dequeued
    }

    func dequeueCell<T: ReuseProtocol>(for indexPath: IndexPath) -> T {

        let dequeued = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
        return dequeued
    }
}

extension UICollectionViewCell {
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: font]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height) + insets.top + insets.bottom + 100
    }
}
