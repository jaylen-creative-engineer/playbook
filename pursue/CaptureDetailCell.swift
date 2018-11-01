//
//  CaptureDetailCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class CaptureDetailCell : UICollectionViewCell {
    
    let peopleFullname = ["Tom Ford", "Versace", "LVME", "Test", "Lit"]
    let peopleUsernames = ["TomFord123", "Versace", "LVME", "Test", "Lit"]
    let peopleImages = ["comment-1", "comment-4", "comment-7", "clean-2", "clean-3"]
    
    let teamId = "teamId"
    let interestId = "interestId"
    let cellId = "cellId"
    let pursuitId = "pursuitId"
    
    var interests = [CreateInterests]()
    let interestsService = InterestServices()
    
    var descriptions = ["Home Redesign", "Road trip", "A foodie's weakness"]
    var pursuitImages = [#imageLiteral(resourceName: "home-remodel"), #imageLiteral(resourceName: "ghost"), #imageLiteral(resourceName: "food")]
    
    let captionLabel : CaptionInputTextView = {
        let tv = CaptionInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let captionUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let inviteLabel : UILabel = {
        let label = UILabel()
        label.text = "Team"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    let teamCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var createNewLabel : UIButton = {
        let button = UIButton()
        button.setTitle("Create New", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        return button
    }()
    
    let interestsLabel : UILabel = {
        let label = UILabel()
        label.text = "Select Interests"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let interestsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let keyPostLabel : UILabel = {
        let label = UILabel()
        label.text = "Mark as a Key Post"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var keyPostSwitch : UISwitch = {
        let sview = UISwitch()
        sview.onTintColor = .blue
        sview.addTarget(self, action: #selector(keyPostSwitchChanged(mySwitch:)), for: .touchUpInside)
        return sview
    }()
    
    let privateLabel : UILabel = {
        let label = UILabel()
        label.text = "Make Pursuit Public"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var privatePostSwitch : UISwitch = {
        let sview = UISwitch()
        sview.onTintColor = .blue
        sview.addTarget(self, action: #selector(privatePostSwitchChanged(mySwitch:)), for: .touchUpInside)
        return sview
    }()
    
    let pursuitsLabel : UILabel = {
        let label = UILabel()
        label.text = "Select Pursuits"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let pursuitsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    

    
    var isCreate = false
    
    func getInterests(){
        interestsService.getInterestsNames { (interest) in
            DispatchQueue.main.async {
                self.interests = interest
                self.interestsCollectionView.reloadData()
            }
        }
    }
    
    @objc func keyPostSwitchChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            print("UISwitch is ON")
        } else {
            print("UISwitch is OFF")
        }
    }
    
    @objc func privatePostSwitchChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            print("UISwitch is ON")
        } else {
            print("UISwitch is OFF")
        }
    }
    
    @objc func handleCreate(){
        isCreate = !isCreate
        
        if isCreate == true {
            interestsLabel.isHidden = false
            interestsCollectionView.isHidden = false
            inviteLabel.isHidden = false
            teamCollectionView.isHidden = false
            privateLabel.isHidden = false
            privatePostSwitch.isHidden = false
            
            createNewLabel.setTitleColor(.black, for: .normal)
            
        } else {
            interestsLabel.isHidden = true
            interestsCollectionView.isHidden = true
            inviteLabel.isHidden = true
            teamCollectionView.isHidden = true
            privateLabel.isHidden = true
            privatePostSwitch.isHidden = true
            
            createNewLabel.setTitleColor(.gray, for: .normal)
            
        }
    }
    
    func setupPursuitCollectionView(){
        pursuitsCollectionView.delegate = self
        pursuitsCollectionView.dataSource = self
        pursuitsCollectionView.register(SavePopoverCells.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(pursuitsLabel)
        addSubview(pursuitsCollectionView)
        addSubview(createNewLabel)
        
        pursuitsLabel.anchor(top: keyPostSwitch.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: pursuitsLabel.intrinsicContentSize.width, height: 16)
        pursuitsCollectionView.anchor(top: pursuitsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        createNewLabel.anchor(top: nil, left: nil, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 34)
        createNewLabel.centerYAnchor.constraint(equalTo: pursuitsLabel.centerYAnchor).isActive = true
        
    }
    
    func setupInterestsCollectionView(){
        interestsCollectionView.delegate = self
        interestsCollectionView.dataSource = self
        interestsCollectionView.register(CreateInterestsCells.self, forCellWithReuseIdentifier: interestId)
        
        addSubview(interestsLabel)
        addSubview(interestsCollectionView)
        
        interestsLabel.isHidden = true
        interestsCollectionView.isHidden = true
        
        interestsLabel.anchor(top: privatePostSwitch.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: interestsLabel.intrinsicContentSize.width, height: 16)
        interestsCollectionView.anchor(top: interestsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
    
    func setupTeamCollectionView(){
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
        teamCollectionView.register(TeamCells.self, forCellWithReuseIdentifier: teamId)
        
        addSubview(inviteLabel)
        addSubview(teamCollectionView)
        
        inviteLabel.isHidden = true
        teamCollectionView.isHidden = true
        
        inviteLabel.anchor(top: pursuitsCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: inviteLabel.intrinsicContentSize.width, height: 16)
        teamCollectionView.anchor(top: inviteLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        
        addSubview(privateLabel)
        addSubview(privatePostSwitch)
        
        privateLabel.isHidden = true
        privatePostSwitch.isHidden = true
        
        privateLabel.anchor(top: teamCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: privateLabel.intrinsicContentSize.width, height: 20)
        privatePostSwitch.centerYAnchor.constraint(equalTo: privateLabel.centerYAnchor).isActive = true
        privatePostSwitch.anchor(top: nil, left: nil, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
    }
    
    func setupPageDetails(){
        addSubview(captionLabel)
        addSubview(captionUnderline)
        
        captionLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 42, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: captionLabel.intrinsicContentSize.height)
        captionUnderline.anchor(top: captionLabel.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        
        addSubview(keyPostLabel)
        addSubview(keyPostSwitch)
        
        keyPostLabel.anchor(top: captionUnderline.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: keyPostLabel.intrinsicContentSize.width, height: 20)
        keyPostSwitch.centerYAnchor.constraint(equalTo: keyPostLabel.centerYAnchor).isActive = true
        keyPostSwitch.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
        
        setupPursuitCollectionView()
        setupTeamCollectionView()
        setupInterestsCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CaptureDetailCell : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            
            textView.text = "Add Caption"
            textView.textColor = .gray
            textView.font = UIFont.boldSystemFont(ofSize: 14)
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
            
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}


extension CaptureDetailCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case teamCollectionView:
            return 6
        case interestsCollectionView:
            return 3
        case pursuitsCollectionView:
            return 5
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case teamCollectionView:
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        default:
            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case teamCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamId, for: indexPath) as! TeamCells
            cell.usernameLabel.text = peopleUsernames[indexPath.item]
            cell.profileImage.image = UIImage(named: peopleImages[indexPath.item])
            return cell
        case interestsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestId, for: indexPath) as! CreateInterestsCells
            return cell
        case pursuitsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SavePopoverCells
            cell.postDetail.text = descriptions[indexPath.item]
            cell.imageView.image = pursuitImages[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! CreatePursuitsCells
            return cell
        }
        //        switch indexPath.item {
        //        case 0:
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailId, for: indexPath) as! CreateDetailsCell
        ////            cell.accessPhotoViewController = self
        //            return cell
        //        default:
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! CreatePursuitsCells
        //            return cell
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case teamCollectionView:
            return CGSize(width: 80, height: 80)
        case pursuitsCollectionView:
            return CGSize(width: 200, height: 220)
        case interestsCollectionView:
            if !interests.isEmpty {
                if let interest_name = interests[indexPath.item].interest_name {
                    let approximateHeightOfLabel = frame.width - 20 - 8
                    let size = CGSize(width: .infinity, height: approximateHeightOfLabel)
                    let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
                    let estimatedFrame = NSString(string: interest_name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                    return CGSize(width: estimatedFrame.width + 50, height: 43)
                }
            }
            return CGSize(width: frame.width / 4, height: 40)
        default:
            return CGSize(width: frame.width, height: frame.height / 1.6)
        }
        
    }
}
