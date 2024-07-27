//
//  SignUpController.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 27.07.24.
//

import UIKit

class SignUpController: UIViewController {
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var fullnameView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var fullnameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
    }
    
    fileprivate func configureUI() {
        emailView.setBorder()
        fullnameView.setBorder()
        passwordView.setBorder()
    }
    
    fileprivate func configureViewModel() {
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
    }
}
