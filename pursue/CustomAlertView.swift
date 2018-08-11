//
//  CustomAlertView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase

class CustomAlertView: UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    let createId = "createId"
    let exploreImageNames = ["fire", "flights", "currency", "map"]
    let exerciseLabelText = ["Start a fire", "How to find cheaper flights?", "Converting your money", "How to read a map?"]
    
    lazy var alertView : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var capturedImage : UIImage = {
       let iv = UIImage()
        return iv
    }()
    
    var contentUrl : URL?
    
    lazy var postDescription : UILabel = {
       let label = UILabel()
        return label
    }()
    
    var is_principle = 0
    var is_step = 0
    
    init(capturedImage : UIImage, contentUrl : URL?, postDescription : String, is_principle : Int, is_step : Int) {
        super.init(nibName: nil, bundle: nil)
        self.capturedImage = capturedImage
        self.contentUrl = contentUrl
        self.postDescription.text = postDescription
        self.is_principle = is_principle
        self.is_step = is_step
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        collectionView.register(CreateAlertViewCell.self, forCellWithReuseIdentifier: createId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        alertView.addSubview(collectionView)
         collectionView.anchor(top: sendLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
    }
    
    func getPursuits(){
        createService.getUserPursuits { (pursuit) in
            self.pursuits.append(pursuit)
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertView)
        alertView.addSubview(sendLabel)
        alertView.addSubview(createButton)
        alertView.addSubview(cancelLabel)
        alertView.addSubview(cancelBackground)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 325)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        sendLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: sendLabel.intrinsicContentSize.width, height: sendLabel.intrinsicContentSize.height)
        createButton.anchor(top: sendLabel.topAnchor, left: nil, bottom: nil, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 18, height: 18)
        cancelLabel.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 14, paddingRight: 0, width: cancelLabel.intrinsicContentSize.width, height: cancelLabel.intrinsicContentSize.height)
        cancelLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 14, paddingRight: 0, width: 100, height: 50)
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCreate(){
        let customAlert = CustomCreateView(capturedImage: capturedImage, contentUrl: contentUrl, pursuitTitle: postDescription.text, is_principle: is_principle, is_step: is_step)
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
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
        if !pursuits.isEmpty {
            return pursuits.count
        } else {
            return 4
//            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) + 10, height: (view.frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !pursuits.isEmpty {
            let pursuitId = pursuits[indexPath.item].pursuitId
            let interestId = pursuits[indexPath.item].interestId
            let filename = NSUUID().uuidString
            
            if contentUrl != nil {
                guard let video = contentUrl else { return }
                let ref = Storage.storage().reference().child("pursuit-video").child(filename)
                ref.putFile(from: video, metadata: nil) { (metadata, err) in
                    if let err = err {
                        print("Failed to upload", err)
                    }
                    
                    var videoUrl = ""
                    
                    ref.downloadURL(completion: { (url, error) in
                        if let error = error {
                            print(error)
                        } else {
                            let stringUrl = url?.absoluteString
                            videoUrl = stringUrl!
                        }
                    })
                    
                    switch true {
                    case self.is_step == 1:
                        self.createService.addStepToPursuit(pursuitId: pursuitId!, interestId: interestId!, stepId: filename, contentUrl: videoUrl, thumbnailUrl: self.capturedImage, stepDescription: self.postDescription.text!, is_visible: 0, is_public: 0)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    case self.is_principle == 1:
                        self.createService.addPrincipleToPursuit(pursuitId: pursuitId!, interestId: interestId!, principleId: filename, contentUrl: videoUrl, thumbnailUrl: self.capturedImage, principleDescription: self.postDescription.text!, is_visible: 0, is_public: 0)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    case self.is_step == 0 && self.is_principle == 0:
                        self.createService.addPostToPursuit(pursuitId: pursuitId!, interestId: interestId!, postId: filename, contentUrl: videoUrl, thumbnailUrl: self.capturedImage, is_step: self.is_step, is_principle: self.is_principle)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    default:
                        assert(false, "Not a valid post")
                    }
                }
            } else {
                switch true {
                case self.is_step == 1:
                    self.createService.addStepToPursuit(pursuitId: pursuitId!, interestId: interestId!, stepId: filename, contentUrl: " ", thumbnailUrl: self.capturedImage, stepDescription: self.postDescription.text!, is_visible: 0, is_public: 0)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                case self.is_principle == 1:
                    self.createService.addPrincipleToPursuit(pursuitId: pursuitId!, interestId: interestId!, principleId: filename, contentUrl: " ", thumbnailUrl: self.capturedImage, principleDescription: self.postDescription.text!, is_visible: 0, is_public: 0)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                case self.is_step == 0 && self.is_principle == 0:
                    self.createService.addPostToPursuit(pursuitId: pursuitId!, interestId: interestId!, postId: filename, contentUrl: " ", thumbnailUrl: self.capturedImage, is_step: self.is_step, is_principle: self.is_principle)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                default:
                    assert(false, "Not a valid post")
                }
            }
        } else {
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
//
//            let customAlert = CustomCreateView(capturedImage: capturedImage, contentUrl: contentUrl, pursuitTitle: postDescription.text, is_principle: is_principle, is_step: is_step)
//            customAlert.providesPresentationContextTransitionStyle = true
//            customAlert.definesPresentationContext = true
//            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            self.present(customAlert, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !pursuits.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomAlertViewCell
            cell.pursuit = pursuits[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomAlertViewCell
            cell.pursuitImageView.image = UIImage(named: exploreImageNames[indexPath.item])
            cell.pursuitLabel.text = exerciseLabelText[indexPath.item]
            return cell
        }
      
    }
}
