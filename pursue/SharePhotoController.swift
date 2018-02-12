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
import Alamofire

class SharePhotoController : UICollectionViewController,  UICollectionViewDelegateFlowLayout {
    
    var selectedImage : UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
        
    }
    
    let cellId = "cellId"
    let stepId = "stepId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.isScrollEnabled = true
        collectionView?.alwaysBounceVertical = true
        collectionView?.alwaysBounceHorizontal = true
        collectionView?.backgroundColor = .white
        collectionView?.register(SharePhotoOptions.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(AddSharingSteps.self, forCellWithReuseIdentifier: stepId)
        collectionView?.register(SharePhotoHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        setupTopBar()
        predictImage()
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    @objc func handleCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    let descriptionUnderline = UIView()

    let textView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let cameraTitle : UILabel = {
        let label = UILabel()
        label.text = "Edit Post"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cameraButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "camera_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let editPictureLabel : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "Edit Image"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addTagsButton : UIButton = {
       let button = UIButton()
        button.setTitle("Select Tags", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(selectTags), for: .touchUpInside)
        return button
    }()
    
    let addTitle : UIButton = {
       let button = UIButton()
        button.setTitle("Add Title", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    lazy var contentModeTextField : UILabel = {
        let label = UILabel()
        label.text = "Content Mode"
        label.font = UIFont.systemFont(ofSize: 14)
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchContentType))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let descriptionTextField : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        tf.attributedPlaceholder = NSAttributedString(string: "Add Description", attributes:attributes)
        return tf
    }()
    
    lazy var selectArrow : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "expand_arrow1600").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchContentType))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let selectTagsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let addStepsLabel : UILabel = {
        let label = UILabel()
        label.text = "Add Steps"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let selectTagsLabel : UILabel = {
        let label = UILabel()
        label.text = "Select Tags"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var checkButton : UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushContent), for: .touchUpInside)
        return button
    }()
    
    
    @objc func switchContentType(){
        let actionController = SkypeActionController()
        actionController.addAction(Action("Inspiration", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Pursuits", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Principles", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SharePhotoHeader
        header.backgroundColor = .black
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SharePhotoOptions
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    let backgroundFill = UIView()
    
    private func setupTopBar(){
        view.addSubview(backgroundFill)
        view.addSubview(cancelButton)
        view.addSubview(checkButton)
        
        backgroundFill.backgroundColor = .clear
        backgroundFill.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        cancelButton.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 16, paddingRight: 0, width: 18, height: 18)
        checkButton.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 12, width: checkButton.intrinsicContentSize.width, height: 18)
        setupImageAndTextViews()
    }
    
    func setupTags(){
        view.addSubview(selectTagsCollection)
        selectTagsCollection.backgroundColor = .clear
        selectTagsCollection.anchor(top: descriptionUnderline.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 320)        
    }
    
    var post : Post?
    
    @objc func pushContent(){
        guard let image = imageView.image else { return }
        guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
        let filename = NSUUID().uuidString
        
        Storage.storage().reference().child("posts").child(filename).putData(uploadData, metadata: nil) { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            let user = Auth.auth().currentUser
            
            guard let postImageUrl = metadata?.downloadURL()?.absoluteString else { return }
            guard let uid = user?.uid else { return }
            
            var parameters = Alamofire.Parameters()
            
            parameters["postId"] = filename
            parameters["userId"] = uid
            parameters["photoUrl"] = postImageUrl
            parameters["postDescription"] = self.descriptionTextField.text
            parameters["is_visible"] = 1
            
            let url = "https://pursuit-jaylenhu27.c9users.io/posts"
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                print("Success fully posted")
            }
            
        }
    }
    
    let categoryLabel = UILabel()
    
    fileprivate func setupImageAndTextViews(){
        view.addSubview(imageView)
        view.addSubview(categoryLabel)
        view.addSubview(contentModeTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(selectArrow)
        view.addSubview(selectTagsCollection)
        
        imageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 224, height: 280)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoryLabel.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: categoryLabel.intrinsicContentSize.width, height: 50)
        
        contentModeTextField.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 48, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: contentModeTextField.intrinsicContentSize.height)
        
        let contentModeUnderline = UIView()
        contentModeUnderline.backgroundColor = .black
        
        view.addSubview(contentModeUnderline)
        
        contentModeUnderline.anchor(top: contentModeTextField.bottomAnchor, left: contentModeTextField.leftAnchor, bottom: nil, right: contentModeTextField.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        selectArrow.anchor(top: contentModeTextField.topAnchor, left: nil, bottom: nil, right: contentModeUnderline.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 21, height: 21)
        
        descriptionTextField.anchor(top: contentModeUnderline.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 48, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: descriptionTextField.intrinsicContentSize.height)
        
        descriptionUnderline.backgroundColor = .black
        
        view.addSubview(descriptionUnderline)
        descriptionUnderline.anchor(top: descriptionTextField.bottomAnchor, left: descriptionTextField.leftAnchor, bottom: nil, right: descriptionTextField.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        setupTags()
    }
    
    let model = GoogLeNetPlaces()
    
    func predictImage(){
        guard let imageToScan = imageView.image else { return }
        if let sceneLabelString = sceneLabel(forImage: imageToScan) {
                categoryLabel.text = sceneLabelString
            }
    }
    
    func sceneLabel (forImage image: UIImage) -> String? {
        if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!) {
            guard let scene = try? model.prediction(sceneImage: pixelBuffer) else {fatalError("Unexpected runtime error")}
            return scene.sceneLabel
        }
        
        return nil
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
