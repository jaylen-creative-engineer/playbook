//
//  EditProfileController.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/30/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class EditProfileController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()

    lazy var saveButton : UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cellId = "cellId"
    
    @objc func handleCamera(){
        let layout = UICollectionViewFlowLayout()
        let cameraController = SelectCameraController(collectionViewLayout: layout)
        navigationController?.present(cameraController, animated: true, completion: nil)
    }
    
    @objc func handleCancel(){
        navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EditProfileCells
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(EditProfileCells.self, forCellWithReuseIdentifier: cellId)
        setupNavBarWithUser()
    }
    
    
    func setupNavBarWithUser() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(saveButton)
        
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        backButton.anchor(top: nil, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 20, height: 20)
        saveButton.anchor(top: nil, left: nil, bottom: nil, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: saveButton.intrinsicContentSize.width, height: saveButton.intrinsicContentSize.height)
        saveButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 85, 0)
    }
}
