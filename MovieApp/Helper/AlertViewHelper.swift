//
//  AlertViewHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit

class AlertViewHelper {
    static func showAlert(title: String = "Error", message: String, style: UIAlertController.Style = .alert) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        return alert
    }
    
    static func showActionSheet(title: String, message: String = "",
                                actionItemTitle: String, cancelItemTitle: String = "Cancel",
                                handler: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let actionItem = UIAlertAction(title: actionItemTitle, style: .default) { _ in
            handler()
        }
        alert.addAction(actionItem)
        
        let cancelItem = UIAlertAction(title: cancelItemTitle, style: .cancel, handler: nil)
        alert.addAction(cancelItem)
        return alert
    }
}
