//
//  LoginController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/11/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import Alamofire

class LoginController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    // MARK: - Handle Logo View
    
    var userPhoto : Data?
    
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
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes:attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 14)
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes:attributes)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var forgotButton : UIButton = {
       let button = UIButton()
        button.setTitle("Forgot", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
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
    
    lazy var facebookIcon : FBSDKLoginButton = {
       let fb = FBSDKLoginButton()
        fb.contentMode = .scaleAspectFill
        fb.delegate = self
        fb.readPermissions = ["email", "public_profile"]
        fb.translatesAutoresizingMaskIntoConstraints = false
        fb.addTarget(self, action: #selector(handleFacebookLogin), for: .touchUpInside)
        return fb
    }()
    
    lazy var googleIcon : GIDSignInButton = {
       let gb = GIDSignInButton()
        gb.contentMode = .scaleAspectFill
        gb.translatesAutoresizingMaskIntoConstraints = false
        gb.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
        return gb
    }()
    
    let haveAccountLabel : UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let signupButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    var socialLoginStack = UIStackView()
    
    @objc func handleForgot(){
        let layout = UICollectionViewFlowLayout()
        let forgotController = ForgotController(collectionViewLayout: layout)
        navigationController?.pushViewController(forgotController, animated: true)
    }
    
    @objc func handleGoogleLogin(){
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc func handleFacebookLogin(){
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let error = error {
                print("Failed to create account: ", error)
                return
            }
            
            guard let uid = user?.uid else { return }
            guard let email = user?.email else { return }
            guard let fullname = user?.displayName else { return }
            
            if let profileImageUrl = user?.photoURL {
                do {
                    let imageData = try Data(contentsOf: profileImageUrl as URL)
                    self.userPhoto = imageData
                } catch {
                    print("Unable to load data: \(error)")
                }
            }
            
            guard let googleProfilePic = self.userPhoto else { return }
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profile-images").child(filename).putData(googleProfilePic, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload", err)
                }
                
                var parameters = Alamofire.Parameters()
                
                parameters["userId"] = uid
                parameters["fullname"] = fullname
                parameters["photoUrl"] = user?.photoURL?.absoluteString
                parameters["email"] = email
                
                let url = "https://pursuit-jaylenhu27.c9users.io/signup"
                
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                    let layout = UICollectionViewFlowLayout()
                    let interestsController = InterestsController(collectionViewLayout: layout)
                    interestsController.viewType = "signupInterest"
                    self.navigationController?.pushViewController(interestsController, animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            })
            
        }

    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        handleFacebookLogin()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    fileprivate func setupInputFields() {
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 64, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: emailTextField.intrinsicContentSize.height)
        
        let emailUnderline = UIView()
        emailUnderline.backgroundColor = .black
        
        view.addSubview(emailUnderline)
        emailUnderline.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: emailTextField.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        view.addSubview(passwordTextField)
        passwordTextField.anchor(top: emailUnderline.bottomAnchor, left: emailUnderline.leftAnchor, bottom: nil, right: emailUnderline.rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: passwordTextField.intrinsicContentSize.height)
        
        let passwordUnderline = UIView()
        passwordUnderline.backgroundColor = .black
        
        view.addSubview(passwordUnderline)
        passwordUnderline.anchor(top: passwordTextField.bottomAnchor, left: passwordTextField.leftAnchor, bottom: nil, right: passwordTextField.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordUnderline.bottomAnchor, left: passwordUnderline.leftAnchor, bottom: nil, right: passwordUnderline.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        view.addSubview(forgotButton)
        forgotButton.anchor(top: loginButton.bottomAnchor, left: nil, bottom: nil, right: loginButton.rightAnchor, paddingTop: 26, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: forgotButton.intrinsicContentSize.width, height: forgotButton.intrinsicContentSize.height)
        
        setupOrLabel()
    }
    
    func setupOrLabel(){
        view.addSubview(orSignInLabel)
        view.addSubview(signInLeftLine)
        view.addSubview(signInRightLine)
        
        orSignInLabel.anchor(top: forgotButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: orSignInLabel.intrinsicContentSize.width, height: orSignInLabel.intrinsicContentSize.height)
        orSignInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInLeftLine.anchor(top: nil, left: loginButton.leftAnchor, bottom: nil, right: orSignInLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0.5)
        signInLeftLine.centerYAnchor.constraint(equalTo: orSignInLabel.centerYAnchor).isActive = true
        signInRightLine.anchor(top: nil, left: orSignInLabel.rightAnchor, bottom: nil, right: loginButton.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
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
        switchToLogin()
    }
    
    func switchToLogin(){
        view.addSubview(haveAccountLabel)
        view.addSubview(signupButton)
        
        let guide = view.safeAreaLayoutGuide
        
        haveAccountLabel.anchor(top: nil, left: loginButton.leftAnchor, bottom: guide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: haveAccountLabel.intrinsicContentSize.width, height: haveAccountLabel.intrinsicContentSize.height)
        signupButton.anchor(top: nil, left: haveAccountLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: signupButton.intrinsicContentSize.width, height: signupButton.intrinsicContentSize.height)
        signupButton.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor).isActive = true
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
        
        GIDSignIn.sharedInstance().uiDelegate = self

        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        view.addSubview(logoContainerView)
        
        logoContainerView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        logoContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setupInputFields()
    }
}
