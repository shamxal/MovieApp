//
//  LoginController.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 27.07.24.
//

import UIKit

class LoginController: UIViewController, Storyboarded {
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var signupTitleLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        emailView.setBorder()
        passwordView.setBorder()
    }
    
    fileprivate func configureViewModel() {
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    }
}
