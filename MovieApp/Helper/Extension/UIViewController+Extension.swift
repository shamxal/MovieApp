//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import UIKit
import SVProgressHUD
import SafariServices

extension UIViewController {
    func transparentNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func hideIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func presentURL(url: String) {
        if #available(iOS 11.0, *) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            if verifyUrl(urlString: url), let url = URL(string: url) {
                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                if !UIApplication.shared.canOpenURL(url as URL) {
                    present(AlertViewHelper.showAlert(message: "Invalid url"), animated: true, completion: nil)
                }
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}

extension UIViewController {
    public var navigationBarHeight: CGFloat {
        var top = self.navigationController?.navigationBar.frame.height ?? 0.0
        top += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return top
    }
    
    public var screenHeight: CGFloat {
        view.window?.screen.bounds.height ?? 0
    }
}

extension UIViewController {
    func showAlert(title: String = "Error", message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        controller.addAction(action)
        present(controller, animated: true)
    }
}
