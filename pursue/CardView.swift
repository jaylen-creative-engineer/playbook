//
//  CardView.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/25/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cornerRadius : CGFloat = 20
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 20
    var shadowColor = UIColor.black
    var shadowOpacity : CGFloat = 0.2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}

class HomeView: UIView {
    
    var cornerRadius : CGFloat = 8
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 10
    var shadowColor = UIColor.black
    var shadowOpacity : CGFloat = 0.2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}

class SmallerCardView : UIView {
    var cornerRadius : CGFloat = 8
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 5
    var shadowColor = UIColor.black
    var shadowOpacity : CGFloat = 0.2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}

class RectangleView : UIView {
    var cornerRadius : CGFloat = 0
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 1
    var shadowColor = UIColor.gray
    var shadowOpacity : CGFloat = 0.2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}

class TopRectangleView : UIView {
    var cornerRadius : CGFloat = 0
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = -1
    var shadowColor = UIColor.gray
    var shadowOpacity : CGFloat = 0.2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
