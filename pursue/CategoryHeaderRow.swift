//
//  CategoryHeaderRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

protocol CategoryHeaderDelegate {
    func goBack()
    func changeToExplore()
    func changeToHome()
    func changeToProfile()
}

class CategoryHeaderRow : UICollectionViewCell {
    
   
    
    func setupPageTitle(){
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageTitle()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

