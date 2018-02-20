//
//  PostSteps.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/18/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitSteps :  UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, StepsResizing {
    let cellId = "cellId"
    
    var accessPursuitDetailController : PursuitsDetailController?
    let skillsLabel = ["Work hard everyday it's very important. A whole lot of extra words. There it is keep getting it, keep pushing through it."]
    
    let pursuitSteps : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let stepsLabel : UILabel = {
       let label = UILabel()
        label.text = "Steps To Take"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        return label
    }()
    
    let downArrow : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "expand_arrow1600").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var adjustedHeight : CGFloat = 0
    
    func cellHeight(height: CGFloat) -> CGFloat {
        adjustedHeight = height
        return height
    }
    
    func setupView(){
        let underlineView = UIView()
        underlineView.backgroundColor = .gray
        
        addSubview(downArrow)
        addSubview(stepsLabel)
        addSubview(pursuitSteps)
        addSubview(underlineView)
        
        stepsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: stepsLabel.intrinsicContentSize.width, height: stepsLabel.intrinsicContentSize.height)
        downArrow.anchor(top: stepsLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 14, width: 25, height: 25)
        pursuitSteps.anchor(top: stepsLabel.bottomAnchor, left: stepsLabel.leftAnchor, bottom: nil, right: downArrow.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 40)
        underlineView.anchor(top: pursuitSteps.bottomAnchor, left: stepsLabel.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostStepsCells
        cell.delegate = self
        cell.skillLabel.text = "Work hard everyday it's very important. A whole lot of extra words. There it is keep getting it, keep pushing through it."
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 48, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillsLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if adjustedHeight != 0.0 {
            pursuitSteps.constraints.forEach { (constraint) in
                constraint.constant = adjustedHeight
            }
            return CGSize(width: frame.width, height: adjustedHeight)
        } else {
            let approximateWidthOfCell = frame.width - 40 - 14 - 12 - 24
            let size = CGSize(width: approximateWidthOfCell, height: .infinity)
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
            let estimatedFrame = NSString(string: skillsLabel[indexPath.item]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            pursuitSteps.constraints.forEach { (constraint) in
                constraint.constant = estimatedFrame.height + 30
            }
            return CGSize(width: frame.width, height: estimatedFrame.height + 30)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        pursuitSteps.dataSource = self
        pursuitSteps.delegate = self
        pursuitSteps.register(PostStepsCells.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
