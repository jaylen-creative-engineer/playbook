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
    let peopleFullname = ["Tom Ford", "Versace", "LVME", "Test", "Lit"]
    let peopleUsernames = ["TomFord123", "Versace", "LVME", "Test", "Lit"]
    let peopleImages = ["comment-1", "comment-4", "comment-7", "clean-2", "clean-3"]
    
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
    
    var descriptions = ["Home Redesign", "Road trip", "A foodie's weakness"]
    var pursuitImages = [#imageLiteral(resourceName: "home-remodel"), #imageLiteral(resourceName: "ghost"), #imageLiteral(resourceName: "food")]
    
    @objc func handleInvite(){
        let inviteController = InviteController(collectionViewLayout: UICollectionViewFlowLayout())
        present(inviteController, animated: true, completion: nil)
    }
    
    func setupCollectionView(){
        alertView.addSubview(peopleCollectionView)
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        peopleCollectionView.register(TeamCells.self, forCellWithReuseIdentifier: cellId)
        peopleCollectionView.anchor(top: addLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
    }
    
    func setupPage(){
        alertView.addSubview(cancelButton)
        alertView.addSubview(addLabel)
        alertView.addSubview(inviteContactsButton)
        
        addLabel.anchor(top: alertView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: addLabel.intrinsicContentSize.width, height: addLabel.intrinsicContentSize.height)
        addLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelButton.anchor(top: nil, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: cancelButton.intrinsicContentSize.width, height: 18)
        cancelButton.centerYAnchor.constraint(equalTo: addLabel.centerYAnchor).isActive = true
        setupCollectionView()
        inviteContactsButton.anchor(top: nil, left: nil, bottom: alertView.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 100, height: 24)
        inviteContactsButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(alertView)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 280)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        setupPage()
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
        cell.profileImage.image = UIImage(named: peopleImages[indexPath.item])
        cell.usernameLabel.text = peopleUsernames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 5, height: 85)
    }
    
}
