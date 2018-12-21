//
//  LoginController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import FirebaseAuth
import FirebaseStorage

class LoginController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Handle Logo View
    
    var userPhoto : Data?
    
    let textBox : LoginRectangleView = {
        let fv = LoginRectangleView()
        fv.translatesAutoresizingMaskIntoConstraints = false
        fv.layer.cornerRadius = 8
        return fv
    }()
    
    let textTopHighlight : LoginTopRectangleView = {
        let fv = LoginTopRectangleView()
        fv.backgroundColor = .white
        fv.translatesAutoresizingMaskIntoConstraints = false
        fv.layer.cornerRadius = 8
        return fv
    }()
    
    let loginLabel : UILabel = {
       let label = UILabel()
        label.text = "LOGIN"
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.init(25))
        return label
    }()
    
    let emailLabel : UILabel = {
       let label = UILabel()
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let orLoginLabel : UILabel = {
       let label = UILabel()
        label.text = "Or Login With"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Handle User Inputs
    
    let emailTextField : TextField = {
        let tf = TextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        tf.layer.cornerRadius = 4
        tf.backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Enter email", attributes:attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField : TextField = {
        let tf = TextField()
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.layer.cornerRadius = 4
        tf.backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes:attributes)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var forgotButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleForgot), for: .touchUpInside)
        return button
    }()

    let haveAccountLabel : UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var signupButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    lazy var signupBackground : UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    var socialLoginStack = UIStackView()
    let profileService = ProfileServices()
    
    @objc func handleForgot(){
        let layout = UICollectionViewFlowLayout()
        let forgotController = ForgotController(collectionViewLayout: layout)
        navigationController?.pushViewController(forgotController, animated: true)
    }
    
    func setupBackgroundTextView(){
        view.addSubview(textBox)
        view.addSubview(textTopHighlight)
        view.addSubview(loginLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(forgotButton)
        
        textBox.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: view.frame.height / 6, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: (view.frame.height / 2) - 60)
        textTopHighlight.anchor(top: textBox.topAnchor, left: textBox.leftAnchor, bottom: textBox.bottomAnchor, right: textBox.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        loginLabel.anchor(top: nil, left: textTopHighlight.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 32, paddingRight: 0, width: loginLabel.intrinsicContentSize.width, height: loginLabel.intrinsicContentSize.height)
        loginLabel.centerYAnchor.constraint(equalTo: textTopHighlight.topAnchor).isActive = true
        emailLabel.anchor(top: loginLabel.bottomAnchor, left: loginLabel.leftAnchor, bottom: nil, right: textTopHighlight.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: emailLabel.intrinsicContentSize.height)
        emailTextField.anchor(top: emailLabel.bottomAnchor, left: emailLabel.leftAnchor, bottom: nil, right: textTopHighlight.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 40)
        
        passwordLabel.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: passwordLabel.intrinsicContentSize.width, height: passwordLabel.intrinsicContentSize.height)
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, left: passwordLabel.leftAnchor, bottom: nil, right: textTopHighlight.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 40)
        
        loginButton.anchor(top: nil, left: textTopHighlight.leftAnchor, bottom: nil, right: textTopHighlight.rightAnchor, paddingTop: 18, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 60)
        loginButton.centerYAnchor.constraint(equalTo: textTopHighlight.bottomAnchor).isActive = true
        forgotButton.anchor(top: loginButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 34)
        forgotButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        switchToLogin()
    }
    
    var customSettingsView = CustomSettingsView()
    
    func switchToLogin(){
//        view.addSubview(termsLabel)
        view.addSubview(haveAccountLabel)
        view.addSubview(signupButton)
        view.addSubview(signupBackground)
        
        let guide = view.safeAreaLayoutGuide
        
//        termsLabel.anchor(top: nil, left: view.leftAnchor, bottom: guide.bottomAnchor, right: textBox.rightAnchor, paddingTop: 9, paddingLeft: 24, paddingBottom: 9, paddingRight: 0, width: 0, height: 40)
        haveAccountLabel.anchor(top: nil, left: textBox.leftAnchor, bottom: guide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 9, paddingRight: 0, width: haveAccountLabel.intrinsicContentSize.width, height: haveAccountLabel.intrinsicContentSize.height)
        signupButton.anchor(top: nil, left: haveAccountLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: signupButton.intrinsicContentSize.width, height: signupButton.intrinsicContentSize.height)
        signupButton.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor).isActive = true
        signupBackground.anchor(top: signupButton.topAnchor, left: haveAccountLabel.leftAnchor, bottom: signupButton.bottomAnchor, right: signupButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: - Handle Login 
    
    lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 28
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let termsLabel : UILabel = {
       let label = UILabel()
        label.text = "By continuing, you agree to our Privacy Policy and Terms of Use."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            
            if let err = err {
                print("Failed to sign in", err)
                self.handleError(err)
                return
            }
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window = UIWindow()
            appDelegate.window?.rootViewController = MainTabController()
            appDelegate.window?.makeKeyAndVisible()
            
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func handleTextInputChange () {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 &&
            passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Handle Doesn't Have Account
    
    @objc func handleShowSignUp() {
        let layout = UICollectionViewFlowLayout()
        let signupController = SignupController(collectionViewLayout: layout)
        present(signupController, animated: true, completion: nil)
    }
    
    // MARK: - Setup Navbar Color
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let interestService = InterestServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.white
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupBackgroundTextView()
    }
}
