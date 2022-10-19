//
//  Color.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 19.10.22.
//

import Foundation
import UIKit

enum ColorName: String {
    case borderColor = "borderColor"
    case genreBgColor = "genreBgColor"
    case genreTextColor = "genreTextColor"
    case tabbarImageTint = "tabbarImageTint"
    case textGray = "textGray"
}

extension UIColor {
    static func getColor(color: ColorName) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}
