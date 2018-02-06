//
//  SearchModalController.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/24/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchModalController : UICollectionViewController, UIViewControllerTransitioningDelegate {
    
    let animator = Animator()
    var transitionType : TransitionType = .pushFromBottom
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        view.addSubview(dismissView)
        dismissView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 24)
        dismissView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }
    
    lazy var dismissView : UIButton = {
       let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.transitionType = self.transitionType
        self.animator.insets = UIEdgeInsets.init(top: 100, left: 30, bottom: 30, right: 30)
        self.animator.duration = 0.3
        return self.animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.animator
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let presentationController = NNBackDropController(presentedViewController: presented, presentingViewController: source, dismissPresentedControllerOnTap : true)
        return presentationController
    }
}

