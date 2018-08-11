//
//  SearchCarousel.swift
//  pursue
//
//  Created by Jaylen Sanders on 8/9/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import iCarousel

class SearchCarousel : UICollectionViewCell {
    
    lazy var carouselView : iCarousel = {
        let ic = iCarousel()
        return ic
    }()
    
     var imageNames = ["788572ee949285fae33dca5d846a4664", "690dae66bfe860df34fc7a756b53c15d", "animals", "business"]
    
    func setupCarousel(){
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.type = .invertedRotary
        addSubview(carouselView)
        carouselView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCarousel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchCarousel : iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 4
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var rowCell = UIView()
        rowCell = UIView(frame: CGRect(x: frame.minX, y: 0, width: 190, height: 230))
        rowCell.isUserInteractionEnabled = true
        rowCell.backgroundColor = .clear
        
        let carouselImage = UIImageView()
        carouselImage.contentMode = .scaleAspectFill
        carouselImage.layer.cornerRadius = 8
        carouselImage.layer.masksToBounds = true
        carouselImage.isUserInteractionEnabled = true
        carouselImage.image = UIImage(named: imageNames[index])
        
        rowCell.addSubview(carouselImage)
        
        carouselImage.anchor(top: rowCell.topAnchor, left: rowCell.leftAnchor, bottom: rowCell.bottomAnchor, right: rowCell.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        return rowCell
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.2
        }
        
        return value
    }
}
