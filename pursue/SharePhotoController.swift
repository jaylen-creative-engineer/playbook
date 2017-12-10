//
//  SharePhotoController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/19/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Firebase
import XLActionController

class SharePhotoController : UIViewController {
    
    var selectedImage : UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        setupImageAndTextViews()
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    @objc func handleCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let cameraTitle : UILabel = {
        let label = UILabel()
        label.text = "EDIT POST"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let backgroundFill : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var checkButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "check").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cameraButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "camera_icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let editPictureLabel : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "EDIT IMAGE"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addTagsButton : UIButton = {
       let button = UIButton()
        button.setTitle("SELECT TAGS", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(selectTags), for: .touchUpInside)
        return button
    }()
    
    let addTitle : UIButton = {
       let button = UIButton()
        button.setTitle("Add Title", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        return button
    }()
    
    lazy var postTypeButton : UIButton = {
        let button = UIButton()
        button.setTitle("CONTENT TYPE", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(selectPostType), for: .touchUpInside)
        return button
    }()
    
    @objc func selectTags() {
        
        let actionController = SkypeActionController()
        actionController.addAction(Action("ANIMALS", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("SPORTS", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("COOKING", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
        
    }
    
    @objc func selectPostType(){
        
        let actionController = SkypeActionController()
        actionController.addAction(Action("POST", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("PURSUIT", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("PRINCIPLE", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("CANCEL", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
        
    }
    
    func setupTopBar(){
        imageView.addSubview(backgroundFill)
        imageView.addSubview(cancelButton)
        imageView.addSubview(cameraTitle)
        imageView.addSubview(checkButton)
        
        backgroundFill.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        cancelButton.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 20, paddingRight: 0, width: 18, height: 18)
        cameraTitle.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: cameraTitle.intrinsicContentSize.width, height: cameraTitle.intrinsicContentSize.height)
        cameraTitle.centerXAnchor.constraint(equalTo: backgroundFill.centerXAnchor).isActive = true
        checkButton.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 12, width: 18, height: 18)
        setupBottomBar()
        
    }
    
    func setupBottomBar(){
        imageView.addSubview(cameraButton)
        imageView.addSubview(editPictureLabel)
        
        cameraButton.anchor(top: nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 30, paddingRight: 0, width: 30, height: 26)
        editPictureLabel.anchor(top: nil, left: cameraButton.rightAnchor, bottom: imageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 30, paddingRight: 0, width: editPictureLabel.intrinsicContentSize.width, height: editPictureLabel.intrinsicContentSize.height)
    }
    
    fileprivate func setupImageAndTextViews(){
        view.addSubview(imageView)
        imageView.addSubview(addTagsButton)
        imageView.addSubview(addTitle)
        imageView.addSubview(postTypeButton)
        
        let guide = view.safeAreaLayoutGuide
        imageView.anchor(top: guide.topAnchor, left: guide.leftAnchor, bottom: guide.bottomAnchor, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addTagsButton.anchor(top: view.centerYAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: addTagsButton.intrinsicContentSize.width, height: addTagsButton.intrinsicContentSize.height)
        addTitle.anchor(top: addTagsButton.bottomAnchor, left: addTagsButton.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: addTitle.intrinsicContentSize.width, height: addTitle.intrinsicContentSize.height)
        postTypeButton.anchor(top: addTitle.bottomAnchor, left: addTitle.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: postTypeButton.intrinsicContentSize.width, height: postTypeButton.intrinsicContentSize.height)
    }
    
    @objc func handleShare() {
        let layout = UICollectionViewFlowLayout()
        let homeController = HomeController(collectionViewLayout: layout)
        navigationController?.pushViewController(homeController, animated: true)
        
//        guard let image = selectedImage else { return }
//        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
//
//        navigationItem.rightBarButtonItem?.isEnabled = false
//
//        let filename = NSUUID().uuidString
//        Storage.storage().reference().child("posts").child(filename).putData(uploadData, metadata: nil) { (metadata, err) in
//            if let err = err {
//                print("Failed to upload", err)
//                self.navigationItem.rightBarButtonItem?.isEnabled = true
//                return
//            }
//
//            guard let imageURL = metadata?.downloadURL()?.absoluteString else { return }
//
//
//            self.saveToDatabaseWithImageURL(imageURL : imageURL)
//        }
    }
    
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    
    fileprivate func saveToDatabaseWithImageURL(imageURL: String) {
        guard let postImage = selectedImage else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let caption = textView.text else { return }
        
        let userPostsRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostsRef.childByAutoId()
        let values = ["imageURL": imageURL, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to save", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            
            NotificationCenter.default.post(name: SharePhotoController.updateFeedNotificationName, object: nil)
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
