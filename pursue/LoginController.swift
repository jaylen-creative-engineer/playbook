//
//  LoginController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    // MARK: - Handle Logo View
    
    let logoContainerView : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "instagram_logo")
        return view
    }()
    
    // MARK: - Handle User Inputs
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        tf.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes:attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        tf.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes:attributes)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var forgotButton : UIButton = {
       let button = UIButton()
        button.setTitle("FORGOT", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleForgot), for: .touchUpInside)
        return button
    }()
    
    let orSignInLabel : UILabel = {
       let label = UILabel()
        label.text = "OR SIGN IN WITH"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let signInLeftLine : UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let signInRightLine : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let facebookIcon : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 30
        iv.image = #imageLiteral(resourceName: "facebook")
        return iv
    }()
    
    let googleIcon : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 30
        iv.image = #imageLiteral(resourceName: "google-plus")
        return iv
    }()
    
    lazy var signupButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 17
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    var stackView = UIStackView()
    var socialLoginStack = UIStackView()
    
    @objc func handleForgot(){
        let layout = UICollectionViewFlowLayout()
        let forgotController = ForgotController(collectionViewLayout: layout)
        navigationController?.pushViewController(forgotController, animated: true)
    }
    
    fileprivate func setupInputFields() {
        
        stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 64, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 160)
        
        view.addSubview(forgotButton)
        forgotButton.anchor(top: stackView.bottomAnchor, left: nil, bottom: nil, right: stackView.rightAnchor, paddingTop: 26, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: forgotButton.intrinsicContentSize.width, height: forgotButton.intrinsicContentSize.height)
        setupOrLabel()
    }
    
    func setupOrLabel(){
        view.addSubview(orSignInLabel)
        view.addSubview(signInLeftLine)
        view.addSubview(signInRightLine)
        
        orSignInLabel.anchor(top: forgotButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: orSignInLabel.intrinsicContentSize.width, height: orSignInLabel.intrinsicContentSize.height)
        orSignInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInLeftLine.anchor(top: nil, left: stackView.leftAnchor, bottom: nil, right: orSignInLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0.5)
        signInLeftLine.centerYAnchor.constraint(equalTo: orSignInLabel.centerYAnchor).isActive = true
        signInRightLine.anchor(top: nil, left: orSignInLabel.rightAnchor, bottom: nil, right: stackView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        signInRightLine.centerYAnchor.constraint(equalTo: orSignInLabel.centerYAnchor).isActive = true
        setupSocialLogin()
        
    }
    
    func setupSocialLogin(){
        view.addSubview(facebookIcon)
        view.addSubview(googleIcon)
        
        googleIcon.anchor(top: signInLeftLine.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        googleIcon.centerXAnchor.constraint(equalTo: signInLeftLine.centerXAnchor).isActive = true
        facebookIcon.anchor(top: signInRightLine.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60.2)
        facebookIcon.centerXAnchor.constraint(equalTo: signInRightLine.centerXAnchor).isActive = true
    }
    
    func addSignInButton(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(signupButton)
        
        signupButton.anchor(top: nil, left: googleIcon.rightAnchor, bottom: guide.bottomAnchor, right: facebookIcon.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 0, height: 37)
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Handle Login 
    
    lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            
            if let err = err {
                print("Failed to sign in", err)
                return
            }
            
            print("Success logged back in:", user?.uid ?? "")
            
            let layout = UICollectionViewFlowLayout()
            let homeController = HomeController(collectionViewLayout: layout)
            self.navigationController?.pushViewController(homeController, animated: true)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleTextInputChange () {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 &&
            passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.black
            loginButton.titleLabel?.textColor = .white
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.white
            loginButton.titleLabel?.textColor = .black
        }
    }
    
    // MARK: Handle Doesn't Have Account
    
    @objc func handleShowSignUp() {
        let signupController = UINavigationController(rootViewController: SignupController())
        present(signupController, animated: true, completion: nil)
    }
    
    // MARK: - Setup Navbar Color
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        view.addSubview(logoContainerView)
        
        logoContainerView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        logoContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setupInputFields()
        addSignInButton()
    }
}
