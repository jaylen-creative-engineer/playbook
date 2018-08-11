//
//  PursuitsDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import ParallaxHeader
import Hero
import Firebase
import AVFoundation
import AVKit
import MediaPlayer

class PursuitsDetailController : UICollectionViewController {
    
    let headerId = "headerId"
    let commentId = "commentId"
    let videoId = "videoId"
    let postId = "postId"
    let teamId = "teamId"
    let dayId = "dayId"
    let pursuitId = "discussionPursuitId"
    let solutionId = "solutionId"
    let cellId = "cellId"
    let challengeId = "challengeId"
    
    var isStandardView = false
    var isChallengeView = false
    
    let homeService = HomeServices()
    
    func standardView(){
        isStandardView = true
        isChallengeView = false
        
//        homeService.getStep(stepId: stepId) { (step) in
//
//        }
        collectionView?.reloadData()
    }
    
    func challengeView(){
        isStandardView = false
        isChallengeView = true
        collectionView?.reloadData()
    }
    
    
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showStepOptions(){
        let customAlert = CustomDetailView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    lazy var floatingCamera : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addSteps), for: .touchUpInside)
        return button
    }()
    
    lazy var stepIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addSteps))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let topBackground : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.8, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var backBackground : PlayView = {
        let view = PlayView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var backIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "back-button").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    @objc func addSteps(){
     
    }
    
    private func setupFloatingCamera(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(floatingCamera)
        floatingCamera.addSubview(stepIcon)
        
        floatingCamera.anchor(top: nil, left: nil, bottom: guide.bottomAnchor, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 40, height: 40)
        
        stepIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        stepIcon.centerXAnchor.constraint(equalTo: floatingCamera.centerXAnchor).isActive = true
        stepIcon.centerYAnchor.constraint(equalTo: floatingCamera.centerYAnchor).isActive = true
    }
    
    func showPursuitsDetail(){
        handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func showDiscussionDetail(){
        handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    func showUserProfile(){
//        let userProfileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
//        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    func showPostDetailForPost(){
        handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        case "isStepDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        case "isImageDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(detail, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    lazy var containerView: CommentInputAccessoryView = {
        let container = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentInputAccessoryView = CommentInputAccessoryView(frame: container)
        return commentInputAccessoryView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func setupBackButton(){
        view.addSubview(backBackground)
        backBackground.addSubview(backIcon)
        
        backBackground.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        backIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 18, height: 18)
        backIcon.centerXAnchor.constraint(equalTo: backBackground.centerXAnchor).isActive = true
        backIcon.centerYAnchor.constraint(equalTo: backBackground.centerYAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(TeamRow.self, forCellWithReuseIdentifier: teamId)
        collectionView?.register(PursuitDay.self, forCellWithReuseIdentifier: dayId)
        collectionView?.register(PostComments.self, forCellWithReuseIdentifier: commentId)
        collectionView?.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: videoId)
        collectionView?.register(PursuitsDetailHeader.self, forCellWithReuseIdentifier: headerId)
        collectionView?.register(DetailChallengeRow.self, forCellWithReuseIdentifier: challengeId)
        collectionView?.register(DetailSolutions.self, forCellWithReuseIdentifier: solutionId)
        collectionView?.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        containerView.isHidden = true
        hero.isEnabled = true
        setupBackButton()
    }
    
    @objc func handlePan(panGesture : UIPanGestureRecognizer){
        let translation = panGesture.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        
        switch panGesture.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            Hero.shared.update(progress)
            
//            let currentPos = CGPoint(x: translation.x + imageView.center.x, y: translation.y + imageView.center.y)
//            Hero.shared.apply(modifiers: [.position(currentPos)], to: imageView)
        default:
            if progress + panGesture.velocity(in: nil).y / view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    var postDescription = ""
}

extension PursuitsDetailController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: videoId, for: indexPath) as! DetailHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch true {
        case isStandardView:
            return 3
        case isChallengeView:
            return 5
        default:
             return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch true {
        case isStandardView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 145)
            case 1:
                return CGSize(width: view.frame.width, height: 550)
            case 2:
                return CGSize(width: view.frame.width, height: 550)
            default:
                assert(false, "Not a valid cell")
            }
        case isChallengeView:
            switch indexPath.item {
            case 0:
                return CGSize(width: view.frame.width, height: 145)
            case 1:
                return CGSize(width: view.frame.width, height: 420)
            case 2:
                return CGSize(width: view.frame.width, height: 550)
            case 3:
                return CGSize(width: view.frame.width, height: 200)
            case 4:
                return CGSize(width: view.frame.width, height: 550)
            default:
                assert(false, "Not a valid cell")
            }
        default:
            assert(false, "Not a valid cell")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch true {
        case isStandardView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
                cell.delegate = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! PursuitDay
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! DetailChallengeRow
                return cell
            }
        case isChallengeView:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath) as! PursuitsDetailHeader
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: solutionId, for: indexPath) as! DetailSolutions
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! PursuitDay
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamRow
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentId, for: indexPath) as! PostComments
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! PursuitDay
                return cell
            }
        default:
            assert(false, "Not a valid type")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 2:
            Analytics.logEvent("Day switch", parameters: nil)
        default:
            assert(false, "Not a vaild selection")
        }
    }
    
}

extension PursuitsDetailController : DetailDelegate {
    func handleSave(for cell: PursuitsDetailHeader) {
        
    }
    
    func handleLike(for cell: PursuitsDetailHeader) {
        
    }
    
    func handleShare(for cell: PursuitsDetailHeader) {
        let customAlert = CustomShareView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
}
