//
//  NibProtocol.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit

public protocol NibProtocol: AnyObject {

    static var nib: UINib { get }
}

public extension NibProtocol {

    static var nib: UINib {

        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

public extension NibProtocol where Self: UIView {

    static func instanceFromNib() -> Self {

        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }

        return view
    }
}

public protocol ReuseProtocol {

    static var reuseIdentifier: String { get }
    var reuseIdentifier: String { get }
}

public extension ReuseProtocol {

    static var reuseIdentifier: String {

        return String(describing: self)
    }

    var reuseIdentifier: String {

        return type(of: self).reuseIdentifier
    }
}

