//
//  CustomOptionsView.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CustomStepToggleView : UIViewController {
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var typeLabel : UILabel = {
        let label = UILabel()
        label.text = "Post Type"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        label.textAlignment = .left
        return label
    }()

    lazy var stepBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleChangeToStep), for: .touchUpInside)
        return button
    }()
    
    lazy var stepLabel : UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangeToStep))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var principleBackground : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleChangeToPrinciple), for: .touchUpInside)
        return button
    }()
    
    lazy var stepCheckMark : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "check").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var principleCheckMark : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "check").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var principleLabel : UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangeToPrinciple))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var cancelLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    
    func setupRows(){
        stepCheckMark.isHidden = true
        principleCheckMark.isHidden = true
        
        view.addSubview(alertView)
        alertView.addSubview(typeLabel)
        alertView.addSubview(stepBackground)
        alertView.addSubview(stepLabel)
        alertView.addSubview(principleBackground)
        alertView.addSubview(principleLabel)
        alertView.addSubview(stepCheckMark)
        alertView.addSubview(principleCheckMark)
        alertView.addSubview(cancelLabel)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 225)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        typeLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: typeLabel.intrinsicContentSize.width, height: typeLabel.intrinsicContentSize.height)
        stepBackground.anchor(top: typeLabel.bottomAnchor, left: typeLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 20)
        stepLabel.anchor(top: stepBackground.topAnchor, left: stepBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: stepLabel.intrinsicContentSize.width, height: stepLabel.intrinsicContentSize.height)
        principleBackground.anchor(top: stepBackground.bottomAnchor, left: stepBackground.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: principleBackground.intrinsicContentSize.width, height: principleBackground.intrinsicContentSize.height)
        principleLabel.anchor(top: principleBackground.topAnchor, left: principleBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: principleLabel.intrinsicContentSize.width, height: principleLabel.intrinsicContentSize.height)
        
        stepCheckMark.anchor(top: stepBackground.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 15, height: 15)
        principleCheckMark.anchor(top: principleBackground.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 15, height: 15)
        cancelLabel.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 14, paddingRight: 0, width: cancelLabel.intrinsicContentSize.width, height: cancelLabel.intrinsicContentSize.height)
        cancelLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
    }
    
    var is_step = 0
    var is_principle = 0
    
    init(is_step : Int, is_principle : Int) {
        super.init(nibName: nil, bundle: nil)
        self.is_step = is_step
        self.is_principle = is_principle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRows()
        
        if is_step == 1 {
            stepLabel.text = "Unmark as Step"
            stepCheckMark.isHidden = false
        } else {
            stepLabel.text = "Mark as Step"
            stepCheckMark.isHidden = true
        }
        
        if is_principle == 1 {
            principleLabel.text = "Unmark as Principle"
            principleCheckMark.isHidden = false
        } else {
             principleLabel.text = "Mark as Principle"
            principleCheckMark.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setupView()
        animateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        dismiss(animated: true, completion: nil)
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
    
    var photoController : PhotoViewController?
    
    @objc func handleChangeToStep(){
        if is_step == 1 {
            stepCheckMark.isHidden = false
            photoController?.is_step = 0
            photoController?.stepLabel.isHidden = true
            photoController?.principleLabel.isHidden = true
            photoController?.pursuitUnderline.isHidden = true
            photoController?.pursuitTitle.isHidden = true
            dismiss(animated: true, completion: nil)
        } else {
            stepCheckMark.isHidden = true
            photoController?.is_step = 1
            photoController?.stepLabel.isHidden = false
            photoController?.principleLabel.isHidden = true
            photoController?.pursuitUnderline.isHidden = false
            photoController?.pursuitTitle.isHidden = false
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleChangeToPrinciple(){
        if is_principle == 1 {
            principleCheckMark.isHidden = false
            photoController?.is_principle = 0
            photoController?.principleLabel.isHidden = true
            photoController?.stepLabel.isHidden = true
            photoController?.pursuitUnderline.isHidden = true
            photoController?.pursuitTitle.isHidden = true
            dismiss(animated: true, completion: nil)
        } else {
            principleCheckMark.isHidden = true
            photoController?.is_principle = 1
            photoController?.principleLabel.isHidden = false
            photoController?.stepLabel.isHidden = true
            photoController?.pursuitUnderline.isHidden = false
            photoController?.pursuitTitle.isHidden = false
            dismiss(animated: true, completion: nil)
        }
       
    }
    
}
