//
//  UIImageView+Extension.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadURL(url: String) {
        if let url = URL(string: url) {
            kf.setImage(with: url)
        }
    }
}
