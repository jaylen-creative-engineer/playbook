//
//  CustomCreateView.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero
import Firebase

class CustomCreateView : UIViewController, InterestNameSelected {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    var accessAlertController : CustomAlertView?
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var pursuitPhoto : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    var contentUrl : URL?
    
    var is_principle = 0
    var is_step = 0
    
    lazy var sendButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "send").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    lazy var sendLabel : UILabel = {
        let label = UILabel()
        label.text = "Create pursuit"
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
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
    
    let selectInterest : UILabel = {
       let label = UILabel()
        label.text = "Select an interest that this pursuit is related to."
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pursuitTitle : UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.boldSystemFont(ofSize: 12)
        tv.isScrollEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 60
        paragraphStyle.paragraphSpacing = 15
        
        let attrString = NSMutableAttributedString(string: "")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        tv.attributedText = attrString
        return tv
    }()
    
    lazy var pursuitUnderline : UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let createService = CreateServices()
    
    @objc func handleSend(){
        let pursuitId = NSUUID().uuidString
        let stepId = NSUUID().uuidString
        let principleId = NSUUID().uuidString
        let postId = NSUUID().uuidString
        
        if (contentUrl != nil) {
            Storage.storage().reference().child("pursuit-video").child(pursuitId).putFile(from: contentUrl!, metadata: nil) { (metadata, err) in
                if let err = err {
                    print("Failed to upload", err)
                }
                guard let videoUrl = metadata?.downloadURL()?.absoluteString else { return }

                if self.interestId != nil {
                    
                    switch true {
                    case self.is_step == 1:
                        self.createService.createStepPursuit(pursuitId: pursuitId, stepId: stepId, interestId: self.interestId!, contentUrl: videoUrl, thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    case self.is_principle == 1:
                        self.createService.createPrinciplePursuit(pursuitId: pursuitId, principleId: principleId, interestId: self.interestId!, contentUrl: videoUrl, thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    case self.is_step == 0 && self.is_principle == 0:
                        self.createService.createPursuit(pursuitId: pursuitId, postId: postId, interestId: self.interestId!, contentUrl: videoUrl, thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    default:
                        assert(false, "Not a valid post")
                    }
                    
                } else {
                    switch true {
                    case self.is_step == 1:
                        self.createService.createStepPursuit(pursuitId: pursuitId, stepId: stepId, interestId: "", contentUrl: videoUrl, thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    case self.is_principle == 1:
                        self.createService.createPrinciplePursuit(pursuitId: pursuitId, principleId: principleId, interestId: "", contentUrl: videoUrl, thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    case self.is_step == 0 && self.is_principle == 0:
                        self.createService.createPursuit(pursuitId: pursuitId, postId: postId, interestId: "", contentUrl: videoUrl, thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    default:
                        assert(false, "Not a valid post")
                    }
                }
                
            }
        } else {
            if self.interestId != nil {
                switch true {
                case self.is_step == 1:
                    self.createService.createStepPursuit(pursuitId: pursuitId, stepId: stepId, interestId: self.interestId!, contentUrl: "", thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                case self.is_principle == 1:
                    self.createService.createPrinciplePursuit(pursuitId: pursuitId, principleId: principleId, interestId: self.interestId!, contentUrl: "", thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                case self.is_step == 0 && self.is_principle == 0:
                    self.createService.createPursuit(pursuitId: pursuitId, postId: postId, interestId: self.interestId!, contentUrl: "", thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                default:
                    assert(false, "Not a valid post")
                }
                
            } else {
                switch true {
                case self.is_step == 1:
                    self.createService.createStepPursuit(pursuitId: pursuitId, stepId: stepId, interestId: "", contentUrl: "", thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                case self.is_principle == 1:
                    self.createService.createPrinciplePursuit(pursuitId: pursuitId, principleId: principleId, interestId: "", contentUrl: "", thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                case self.is_step == 0 && self.is_principle == 0:
                    self.createService.createPursuit(pursuitId: pursuitId, postId: postId, interestId: "", contentUrl: "", thumbnailUrl: self.pursuitPhoto.image!, pursuitDescription: self.pursuitTitle.text, is_step: self.is_step, is_principle: self.is_principle, is_visible: 0, is_public: 0)
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                default:
                    assert(false, "Not a valid post")
                }
            }
        }
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    init(capturedImage : UIImage?, contentUrl : URL?, pursuitTitle : String?, is_principle : Int, is_step : Int) {
        super.init(nibName: nil, bundle: nil)
        self.pursuitPhoto.image = capturedImage
        self.contentUrl = contentUrl
        self.pursuitTitle.text = pursuitTitle
        self.is_principle = is_principle
        self.is_step = is_step
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CreateInterestsCells.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        view.addSubview(selectInterest)
        
        selectInterest.anchor(top: pursuitUnderline.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 28, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: selectInterest.intrinsicContentSize.width, height: selectInterest.intrinsicContentSize.height)
        collectionView.anchor(top: selectInterest.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertView)
        alertView.addSubview(sendLabel)
        alertView.addSubview(cancelLabel)
        alertView.addSubview(pursuitPhoto)
        alertView.addSubview(pursuitTitle)
        alertView.addSubview(pursuitUnderline)
        alertView.addSubview(sendButton)
        alertView.addSubview(cancelBackground)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 450)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        
        sendLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: sendLabel.intrinsicContentSize.width, height: sendLabel.intrinsicContentSize.height)
        pursuitPhoto.anchor(top: sendLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 105, height: 120)
        pursuitPhoto.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        pursuitTitle.anchor(top: pursuitPhoto.bottomAnchor, left: pursuitPhoto.leftAnchor, bottom: nil, right: pursuitPhoto.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: pursuitTitle.intrinsicContentSize.height)
        pursuitUnderline.anchor(top: pursuitTitle.bottomAnchor, left: pursuitTitle.leftAnchor, bottom: nil, right: pursuitTitle.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        sendButton.anchor(top: alertView.topAnchor, left: nil, bottom: nil, right: alertView.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 18, height: 18)
        
        cancelLabel.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 14, paddingRight: 0, width: cancelLabel.intrinsicContentSize.width, height: cancelLabel.intrinsicContentSize.height)
        cancelLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelBackground.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 14, paddingRight: 0, width: 100, height: 50)
        cancelBackground.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupCollectionView()
        getInterestsNames()
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
    
    let interestService = InterestServices()
    var interests = [CreateInterests]()
    var interestId : String?
    
    func getInterestsNames(){
        interestService.getInterestsNames { (interests) in
            interests.forEach({ (interest) in
                self.interests.append(interest)
                self.collectionView.reloadData()
            })
        }
    }
    
    func interestSelected(for cell: CreateInterestsCells) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        interestId = self.interests[indexPath.item].interestId
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

extension CustomCreateView : UITextViewDelegate {
    
}

extension CustomCreateView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CreateInterestsCells
        cell.interest = interests[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
}
