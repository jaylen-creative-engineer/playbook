//
//  CustomFriendPopover.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/18/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomFriendPopover : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    var pursuitId : Int?
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var addLabel : UILabel = {
        let label = UILabel()
        label.text = "Add Team"
        label.font = UIFont(name: "Lato-Bold", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var sendButton : UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    lazy var inviteContactsButton : UIButton = {
       let button = UIButton()
        button.setTitle("Invite Contacts", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleInvite), for: .touchUpInside)
        return button
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let peopleCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let inviteFriendsLabel : UILabel = {
       let label = UILabel()
        label.text = "Invite friends to join you on this pursuit."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let profileServices = ProfileServices()
    var users = [User]()
    
    func getTeam(){
        profileServices.getUsersAdded { (added) in
            DispatchQueue.main.async {
                self.users = added.added ?? []
                if added.added?.first?.userId == nil {
                    self.view.addSubview(self.inviteFriendsLabel)
                    self.inviteFriendsLabel.isHidden = false
                    self.inviteFriendsLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
                    self.inviteFriendsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    self.inviteFriendsLabel.centerYAnchor.constraint(equalTo: self.peopleCollectionView.centerYAnchor).isActive = true
                } else if added.added?.first?.userId != nil {
                    self.inviteFriendsLabel.isHidden = true
                }
                
                self.peopleCollectionView.reloadData()
            }
        }
    }
    
    @objc func handleInvite(){
        let inviteController = InviteController(collectionViewLayout: UICollectionViewFlowLayout())
        present(inviteController, animated: true, completion: nil)
    }
    
    @objc func handleSend(){
        users.forEach { (value) in
            profileServices.sendAddedUsers(pursuitId: pursuitId, userId: value.userId, is_following: 1)
        }
        
        NotificationCenter.default.post(name: CustomFriendPopover.updateTeamNotificationName, object: nil)
    }
    
    static let updateTeamNotificationName = NSNotification.Name(rawValue: "UpdateTeam")

    func setupCollectionView(){
        alertView.addSubview(peopleCollectionView)
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        peopleCollectionView.register(TeamCells.self, forCellWithReuseIdentifier: cellId)
        peopleCollectionView.anchor(top: addLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
    }
    
    func setupPage(){
        alertView.addSubview(addLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(sendButton)
        alertView.addSubview(inviteContactsButton)
        
        addLabel.anchor(top: alertView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: addLabel.intrinsicContentSize.width, height: addLabel.intrinsicContentSize.height)
        addLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelButton.anchor(top: nil, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: cancelButton.intrinsicContentSize.width, height: 18)
        cancelButton.centerYAnchor.constraint(equalTo: addLabel.centerYAnchor).isActive = true
        setupCollectionView()
        inviteContactsButton.anchor(top: nil, left: nil, bottom: alertView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 100, height: 24)
        inviteContactsButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: addLabel.centerYAnchor).isActive = true
        sendButton.anchor(top: nil, left: nil, bottom: nil, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 80, height: 18)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(alertView)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 280)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        setupPage()
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        getTeam()
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
    
    
}


extension CustomFriendPopover : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TeamCells
        cell.accessFriendPopover = self
        cell.team = users[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 5, height: 85)
    }
    
}
