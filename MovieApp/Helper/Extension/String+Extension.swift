//
//  String+Extension.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 19.07.24.
//

import UIKit
import Foundation

extension String {
    func heightOfString(usingFont font: UIFont = .systemFont(ofSize: 14)) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont = .systemFont(ofSize: 14)) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: font]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height * 1.5) + insets.top + insets.bottom
    }
}
