//
//  RatingsCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/26/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class RatingsCell: UICollectionViewCell {
    
    let ratingButton : UIButton = {
       let button = UIButton()
        button.setTitle("9", for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 0.4
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ratingButton)
        ratingButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RatingOne : RatingsCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingButton.setTitle("8", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RatingTwo : RatingsCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingButton.setTitle("7", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RatingThree : RatingsCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingButton.setTitle("6", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RatingFour : RatingsCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingButton.setTitle("5", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoreOptions : RatingsCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingButton.setTitle("5", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
