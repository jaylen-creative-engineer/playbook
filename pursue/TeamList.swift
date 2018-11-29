//
//  TeamRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/25/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

protocol TeamListDelegate {
    
    func handleAddFriends(for cell : TeamList)
}

class TeamList : UICollectionViewCell {
    
    var team : [User]? {
        didSet {
            for value in team ?? [] {
                if value.userId == nil {
                    addSubview(noTeam)
                    
                    noTeam.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                    noTeam.anchor(top: teamLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: noTeam.intrinsicContentSize.width, height: 18)
                }
            }
            
            collectionView.reloadData()
        }
    }
    
    var delegate : TeamListDelegate?
    var accessDetailController : PostDetailController?
    let cellId = "cellId"
    
    var added = [User]()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let teamLabel : UILabel = {
       let label = UILabel()
        label.text = "Team"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var addTeamButton : UIButton = {
       let button = UIButton()
        button.setTitle("Add Friends", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleInvite), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        return button
    }()
    
    lazy var inviteTeam : UIButton = {
       let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var inviteButton : UIButton = {
       let button = UIButton()
        button.setTitle("Invite Friends", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleInvite), for: .touchUpInside)
        return button
    }()
    
    lazy var inviteIcon : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleInvite))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var inviteBackground : UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(handleInvite), for: .touchUpInside)
        return button
    }()
    
    let noTeam : UILabel = {
        let label = UILabel()
        label.text = "No Team Members Added Yet"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    func addToUser(){
        
    }
    @objc func handleInvite(){
        delegate?.handleAddFriends(for: self)
    }
    
    func setupView(){
        addSubview(teamLabel)
        addSubview(addTeamButton)
        addSubview(collectionView)

        teamLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: teamLabel.intrinsicContentSize.width, height: 16)
        addTeamButton.centerYAnchor.constraint(equalTo: teamLabel.centerYAnchor).isActive = true
        addTeamButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 120, height: 34)
        
        collectionView.anchor(top: teamLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TeamCells.self, forCellWithReuseIdentifier: cellId)
    }
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            return
        }
        
        let p = gestureReconizer.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            var cell = self.collectionView.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
        } else {
            print("Could not find index path")
        }
    }
    
    func changeToProfile(userId : Int){
        accessDetailController?.handleChangeToProfile(userId: userId)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TeamList : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TeamCells
        cell.team = team?[indexPath.item]
        cell.isDetailView = true
        cell.accessTeamView = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessDetailController?.handleChangeToProfile(userId: (team?[indexPath.item].userId)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 5, height: 85)
    }
}
