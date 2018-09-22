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
    var shadowOffSetHeight : CGFloat = 2.5
    var shadowColor = UIColor.black
    var shadowOpacity : CGFloat = 0.4
    
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

class TopCardView: UIView {
    
    var cornerRadius : CGFloat = 20
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = -2.5
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

class HomeCellRectangleView : UIView {
    
    var cornerRadius : CGFloat = 8
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 3
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

class PlayView: UIView {
    
    var cornerRadius : CGFloat = 15
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

class MessageView: UIView {
    
    var cornerRadius : CGFloat = 17
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 4
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

class ChatMessageView : UIView {
    var cornerRadius : CGFloat = 12
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 1
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

class LargePlayView: UIView {
    
    var cornerRadius : CGFloat = 25
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

class TabView: UIView {
    
    var cornerRadius : CGFloat = 32
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

class FollowRectangleView: UIView {
    
    var cornerRadius : CGFloat = 18
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 3
    var shadowColor = UIColor.black
    var shadowOpacity : CGFloat = 0.7
    
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

class SolutionCardView: UIView {
    
    var cornerRadius : CGFloat = 4
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 1
    var shadowColor = UIColor.black
    var shadowOpacity : CGFloat = 0.3
    
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



class SearchCardView: UIView {
    
    var cornerRadius : CGFloat = 4
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 1
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

class LoginRectangleView: UIView {
    
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

class LoginTopRectangleView: UIView {
    
    var cornerRadius : CGFloat = 8
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = -2
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

class StoryRectangleView: UIView {
    
    var cornerRadius : CGFloat = 8
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 3
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

class StoryTopRectangleView: UIView {
    
    var cornerRadius : CGFloat = 8
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 2
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

class FollowRectangleTopView: UIView {
    
    var cornerRadius : CGFloat = 2
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = -5
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

class GroupChatView : UIView {
    var cornerRadius : CGFloat = 12
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
        layer.shouldRasterize = true
        layer.shadowOpacity = Float(shadowOpacity)
    }
}

class TopRectangleView : UIView {
    var cornerRadius : CGFloat = 0
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = -5
    var shadowColor = UIColor.gray
    var shadowOpacity : CGFloat = 0.5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 3
        
        let scale = true
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

class ResizedHomeImage : UIImageView {
    
    func setupResize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIImage {
    
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        guard let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext() else { fatalError("Could Find New Image") }
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
    
}

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func setGradient(colorOne : UIColor, colorTwo : UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

