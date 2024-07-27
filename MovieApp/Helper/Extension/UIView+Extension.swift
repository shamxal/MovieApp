//
//  UIView+Extension.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 27.07.24.
//

import UIKit
import Foundation

extension UIView {
    
    func setBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "tabbarImageTint")?.cgColor
    }
}
