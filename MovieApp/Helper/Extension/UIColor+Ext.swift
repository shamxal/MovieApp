//
//  UIColor.swift
//  DMV Practice Test
//
//  Created by Shamkhal on 3/21/21.
//

import UIKit

extension UIColor {
    convenience init(hexStr: String, colorAlpha: CGFloat = 1) {
        var rgbHexInt: UInt64 = 0
        
        let scanner = Scanner(string: hexStr)
        scanner.scanLocation = 0
        scanner.scanHexInt64(&rgbHexInt)
        
        self.init(red: CGFloat((rgbHexInt & 0xff0000) >> 16) / 0xff,
                  green: CGFloat((rgbHexInt & 0xff00) >> 8) / 0xff,
                  blue: CGFloat(rgbHexInt & 0xff) / 0xff,
                  alpha: colorAlpha)
    }
}
