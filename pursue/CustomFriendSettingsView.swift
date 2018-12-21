//
//  CustomFriendSettingsView.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/13/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomFriendSettingsView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    var accessLoginController : LoginController?
    var userId : String?
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var settingsLabel : UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    lazy var blockLabel : UIButton = {
        let button = UIButton()
//        button.setTitle("Block User", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .top
        button.addTarget(self, action: #selector(handleEditClick), for: .touchUpInside)
        return button
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelBottomButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .top
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    func setupLabels(){
        view.addSubview(blockLabel)
        view.addSubview(cancelBottomButton)
        
        blockLabel.anchor(top: settingsLabel.bottomAnchor, left: settingsLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
        cancelBottomButton.anchor(top: nil, left: alertView.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 34)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "is_blocked-\(String(describing : userId))") == true {
            blockLabel.setTitle("Block User", for: .normal)
        } else if defaults.bool(forKey: "is_blocked-\(String(describing : userId))") == false {
            blockLabel.setTitle("Unblock User", for: .normal)

        }
        
        view.addSubview(alertView)
        alertView.addSubview(settingsLabel)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 260)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        settingsLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: settingsLabel.intrinsicContentSize.width, height: settingsLabel.intrinsicContentSize.height)
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @objc func handleChangeToInvite(){
        let inviteController = InviteController(collectionViewLayout: UICollectionViewFlowLayout())
        present(inviteController, animated: true, completion: nil)
    }

    @objc func handleEditClick(){
        let defaults = UserDefaults.standard
       
        if defaults.bool(forKey: "is_blocked-\(String(describing : userId))") == true {
            let alert = UIAlertController(title: "Block User", message: "Are you sure you would like to block this user?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: dismissAlertView))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: sendToDatabase))
            self.present(alert, animated: true, completion: nil)
            
            let editController = EditProfileController()
            present(editController, animated: true, completion: nil)
        } else if defaults.bool(forKey: "is_blocked-\(String(describing : userId))") == false {
            let alert = UIAlertController(title: "Unblock User", message: "Are you sure you would like to unblock this user?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: dismissAlertView))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: unblockUser))
            self.present(alert, animated: true, completion: nil)
            
            let editController = EditProfileController()
            present(editController, animated: true, completion: nil)
        }
    }
    
    let createServices = CreateServices()
    
    func getBlockStatus(){
        
    }
    
    func unblockUser(action : UIAlertAction){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "is_blocked-\(String(describing: userId))")
    }
    
    func sendToDatabase(action : UIAlertAction){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "is_blocked-\(String(describing: userId))")
//       createServices.submitBlock(friendId: userId)
    }
    
    func dismissAlertView(action : UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
