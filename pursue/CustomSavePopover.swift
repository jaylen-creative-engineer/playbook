//
//  CustomPursuitPopover.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/14/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Mixpanel

class CustomSavePopover : UIViewController {
    
    var post : Post?
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var saveLabel : UILabel = {
        let label = UILabel()
        label.text = "Save To"
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
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        return button
    }()
    
    lazy var dismissBackground : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let postCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let engagementService = EngagementServices()
    let profileService = ProfileServices()
    let createService = CreateServices()
    var pursuits = [Pursuit]()
    var accessDetailController : PostDetailController?
    
    func getUserPursuit(){
        profileService.getUsersPursuits { (pursuitData) in
            DispatchQueue.main.async {
                self.pursuits = pursuitData
                self.postCollectionView.reloadData()
            }
        }
    }
    
    func setupCollectionView(){
        alertView.addSubview(postCollectionView)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(SavePopoverCells.self, forCellWithReuseIdentifier: cellId)
        postCollectionView.anchor(top: saveLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
    }
    
    func setupPage(){
        alertView.addSubview(cancelButton)
        alertView.addSubview(saveLabel)
        
        saveLabel.anchor(top: alertView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
        saveLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelButton.anchor(top: nil, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 120, height: 34)
        cancelButton.centerYAnchor.constraint(equalTo: saveLabel.centerYAnchor).isActive = true
        setupCollectionView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserPursuit()
        view.addSubview(alertView)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 380)
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
    
    static let updateEngagementsNotificationName = NSNotification.Name(rawValue: "UpdateEngagements")
    
}


extension CustomSavePopover : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SavePopoverCells
        cell.pursuit = pursuits[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Mixpanel.mainInstance().track(event: "Post Saved")
        engagementService.toggleSave(postId: 1, is_saved: 1)
        
        let currentPursuit = pursuits[indexPath.item]
        guard let pursuitId = currentPursuit.pursuitId else { return }
        createService.savePost(pursuitId: pursuitId, videoUrl: post?.videoUrl, thumbnailUrl: post?.thumbnailUrl, posts_description: post?.description)
        handleCancel()
        NotificationCenter.default.post(name: CustomSavePopover.updateEngagementsNotificationName, object: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pursuits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 220)
    }
    
}
