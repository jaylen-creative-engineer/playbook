//
//  ProfileStepCell.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 12/22/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class ProfileStepCell : UICollectionViewCell {
    
    let cellBackgroundColor : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    let stepLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let tableView : UITableView = {
       let tv = UITableView()
        return tv
    }()
    
    func setupView(){
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
