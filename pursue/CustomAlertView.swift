//
//  CustomAlertView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero

class CustomAlertView: UIViewController{
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    
    lazy var alertView : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var sendLabel : UILabel = {
       let label = UILabel()
        label.text = "Send To"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()
    
    lazy var cancelBackground : UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCancel))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var cancelLabel : UILabel = {
        let label = UILabel()
        label.text = "Cancel"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCancel))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var createButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        return button
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let createService = CreateServices()
    var pursuits = [Pursuit]()
    
    func setupCollectionView(){
        collectionView.register(CustomAlertViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        alertView.addSubview(collectionView)
         collectionView.anchor(top: sendLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 190)
    }
    
    func getPursuits(){
        createService.getUserPursuits { (pursuit) in
            self.pursuits.append(pursuit)
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isHeroEnabled = true
        view.addSubview(alertView)
        alertView.addSubview(sendLabel)
        alertView.addSubview(createButton)
        alertView.addSubview(cancelLabel)
        alertView.addSubview(cancelBackground)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 325)
        sendLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: sendLabel.intrinsicContentSize.width, height: sendLabel.intrinsicContentSize.height)
        createButton.anchor(top: sendLabel.topAnchor, left: nil, bottom: nil, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 18, height: 18)
        cancelLabel.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: cancelLabel.intrinsicContentSize.width, height: cancelLabel.intrinsicContentSize.height)
        cancelLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 100, height: 50)
        cancelBackground.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       setupCollectionView()
       getPursuits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    @objc func handleCancel(){
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType =  .fade
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleCreate(){
        let customAlert = CustomCreateView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
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

extension CustomAlertView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) + 10, height: (view.frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pursuitId = pursuits[indexPath.item].pursuitId
//        createService.addPostToPursuit(pursuitId: pursuitId, postId: <#T##String#>, contentUrl: <#T##String#>, thumbnailUrl: <#T##String#>)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomAlertViewCell
        return cell
    }
}
