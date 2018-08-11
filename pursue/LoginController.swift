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
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire

class LoginController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    // MARK: - Handle Logo View
    
    var userPhoto : Data?
    
    let textBox : LoginRectangleView = {
        let fv = LoginRectangleView()
        fv.backgroundColor = .white
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
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
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
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.darkGray,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
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

    lazy var customFacebookLogin : UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.rgb(red: 59, green: 89, blue: 152)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(handleFacebookLogin), for: .touchUpInside)
        return button
    }()
    
    let haveAccountLabel : UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var googleIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "google_plus_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var facebookIcon : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "facebook_white_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    let facebookLoginButton : FBSDKLoginButton = {
       let fbutton = FBSDKLoginButton()
        fbutton.backgroundColor = .blue
        return fbutton
    }()
    
    lazy var customGoogleLogin : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor.rgb(red: 219, green: 50, blue: 54)
        button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
        return button
    }()

    var socialLoginStack = UIStackView()
    let profileService = ProfileServices()
    
    @objc func handleForgot(){
        let layout = UICollectionViewFlowLayout()
        let forgotController = ForgotController(collectionViewLayout: layout)
        navigationController?.pushViewController(forgotController, animated: true)
    }
    
    @objc func handleGoogleLogin(){
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc func handleFacebookLogin(){
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else { return }
            
            let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            Auth.auth().signIn(with: credentials) { (user, error) in
                if let error = error {
                    print("Failed to create account: ", error)
                    return
                }
                
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
                    
                    guard let photoUrl = user?.photoURL?.absoluteString else { return }
                    
                    self.profileService.socialLogin(email: email, fullname: fullname, photoUrl: photoUrl, completion: { (_) in
                        let layout = UICollectionViewFlowLayout()
                        let interestsController = InterestsController(collectionViewLayout: layout)
                        interestsController.viewType = "signupInterest"
                        self.navigationController?.pushViewController(interestsController, animated: true)
                    })
                })
                
            }
        }
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
        
        textBox.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 64, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: view.frame.height / 2)
        textTopHighlight.anchor(top: textBox.topAnchor, left: textBox.leftAnchor, bottom: textBox.bottomAnchor, right: textBox.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        loginLabel.anchor(top: nil, left: textTopHighlight.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 32, paddingRight: 0, width: loginLabel.intrinsicContentSize.width, height: loginLabel.intrinsicContentSize.height)
        loginLabel.centerYAnchor.constraint(equalTo: textTopHighlight.topAnchor).isActive = true
        emailLabel.anchor(top: loginLabel.bottomAnchor, left: loginLabel.leftAnchor, bottom: nil, right: textTopHighlight.rightAnchor, paddingTop: 42, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: emailLabel.intrinsicContentSize.height)
        emailTextField.anchor(top: emailLabel.bottomAnchor, left: emailLabel.leftAnchor, bottom: nil, right: textTopHighlight.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 40)
        
        passwordLabel.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: nil, paddingTop: 28, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: passwordLabel.intrinsicContentSize.width, height: passwordLabel.intrinsicContentSize.height)
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, left: passwordLabel.leftAnchor, bottom: nil, right: textTopHighlight.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 40)
        
        loginButton.anchor(top: nil, left: textTopHighlight.leftAnchor, bottom: nil, right: textTopHighlight.rightAnchor, paddingTop: 18, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 60)
        loginButton.centerYAnchor.constraint(equalTo: textTopHighlight.bottomAnchor).isActive = true
        forgotButton.anchor(top: loginButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: forgotButton.intrinsicContentSize.width, height: forgotButton.intrinsicContentSize.height)
        forgotButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        socialLogin()
    }
    
    func socialLogin(){
        view.addSubview(orLoginLabel)
        view.addSubview(customFacebookLogin)
        view.addSubview(customGoogleLogin)
        view.addSubview(googleIcon)
        view.addSubview(facebookIcon)

        orLoginLabel.anchor(top: passwordTextField.bottomAnchor, left: passwordTextField.leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: orLoginLabel.intrinsicContentSize.width, height: orLoginLabel.intrinsicContentSize.height)
        customFacebookLogin.anchor(top: nil, left: nil, bottom: nil, right: passwordTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 30)
        customFacebookLogin.centerYAnchor.constraint(equalTo: orLoginLabel.centerYAnchor).isActive = true
        customGoogleLogin.anchor(top: customFacebookLogin.topAnchor, left: nil, bottom: customFacebookLogin.bottomAnchor, right: customFacebookLogin.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 60, height: 0)
        googleIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 13)
        googleIcon.centerYAnchor.constraint(equalTo: customGoogleLogin.centerYAnchor).isActive = true
        googleIcon.centerXAnchor.constraint(equalTo: customGoogleLogin.centerXAnchor).isActive = true
        facebookIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 8, height: 15)
        facebookIcon.centerYAnchor.constraint(equalTo: customFacebookLogin.centerYAnchor).isActive = true
        facebookIcon.centerXAnchor.constraint(equalTo: customFacebookLogin.centerXAnchor).isActive = true
        switchToLogin()
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        handleFacebookLogin()
    }
    
    var customSettingsView = CustomSettingsView()
    
    func facebookSignOut(){
        customSettingsView.accessLoginController = self
        loginButtonDidLogOut(customFacebookLogin as! FBSDKLoginButton)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }

    func setupSocialLogin(){
        view.addSubview(customGoogleLogin)
        
        customGoogleLogin.anchor(top: loginButton.bottomAnchor, left: loginButton.leftAnchor, bottom: nil, right: loginButton.rightAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        switchToLogin()
        view.addSubview(customFacebookLogin)
        customFacebookLogin.anchor(top: customGoogleLogin.bottomAnchor, left: customGoogleLogin.leftAnchor, bottom: nil, right: customGoogleLogin.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
       
    }
    
    func switchToLogin(){
        view.addSubview(haveAccountLabel)
        view.addSubview(signupButton)
        
        let guide = view.safeAreaLayoutGuide
        
        haveAccountLabel.anchor(top: nil, left: textBox.leftAnchor, bottom: guide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 24, paddingRight: 0, width: haveAccountLabel.intrinsicContentSize.width, height: haveAccountLabel.intrinsicContentSize.height)
        signupButton.anchor(top: nil, left: haveAccountLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: signupButton.intrinsicContentSize.width, height: signupButton.intrinsicContentSize.height)
        signupButton.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor).isActive = true
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
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            
            if let err = err {
                print("Failed to sign in", err)
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
        GIDSignIn.sharedInstance().uiDelegate = self

        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.white
        setupBackgroundTextView()
    }
}
