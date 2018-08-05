//
//  SNSlider.swift
//  Pods
//
//  Created by Paul Jeannot on 04/05/2016.
//
//

import UIKit

open class SNSlider: UIView {
    
    fileprivate var slider:UIScrollView
    fileprivate var numberOfPages:Int
    fileprivate var startingIndex:Int
    fileprivate var data = [SNFilter]()
    
    open weak var dataSource:SNSliderDataSource?
    
    public override init(frame: CGRect) {
        print(frame)
        numberOfPages = 3
        startingIndex = 0
        self.slider = UIScrollView()
        
        super.init(frame: frame)
        self.addSubview(self.slider)
        self.slider.translatesAutoresizingMaskIntoConstraints = false
        self.slider.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.slider.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.slider.rightAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.slider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.slider.delegate = self
        self.slider.isPagingEnabled = true
        self.slider.bounces = false
        self.slider.showsHorizontalScrollIndicator = false
        self.slider.showsVerticalScrollIndicator = false
        self.slider.layer.zPosition = 1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func reloadData() {
        self.cleanData()
        self.loadData()
        self.presentData()
    }
    
    open func slideShown() -> SNFilter {
        let index = self.slider.contentOffset.x / slider.frame.size.width
        return data[Int(index)]
    }
    
    fileprivate func cleanData() {
        for v in subviews {
            let filter = v as? SNFilter
            if filter != nil {
                v.removeFromSuperview()
            }
        }
        
        for s in slider.subviews {
            let sticker = s as? SNSticker
            if  sticker != nil {
                s.removeFromSuperview()
            }
        }
        
        data.removeAll()
    }
    
    fileprivate func loadData() {
        
        self.numberOfPages = dataSource!.numberOfSlides(self)
        self.startingIndex = dataSource!.startAtIndex(self)
        self.slider.contentSize = CGSize(width: self.frame.width*(CGFloat(numberOfPages+2)), height: self.frame.height)
        
        var filter = dataSource!.slider(self, slideAtIndex:self.numberOfPages-1).copy() as! SNFilter
        data.append(filter)
        
        for i in 0..<self.numberOfPages {
            let filter = dataSource!.slider(self, slideAtIndex:i)
            data.append(filter)
        }
        
        filter = dataSource!.slider(self, slideAtIndex:0).copy() as! SNFilter
        data.append(filter)
        
        self.slider.scrollRectToVisible(CGRect(x: positionOfPageAtIndex(startingIndex),y: 0,width: self.frame.width,height: self.frame.height), animated:false);
    }
    
    fileprivate func presentData() {
        
        for i in 0..<data.count {
            weak var filter:SNFilter! = data[i]
            filter.layer.zPosition = 0
            filter.mask(filter.frame)
            filter.updateMask(filter.frame, newXPosition: positionOfPageAtIndex(i-startingIndex-2))
            self.addSubview(filter)
            
            for s in data[i].stickers {
                s.frame.origin.x = s.frame.origin.x + positionOfPageAtIndex(i-1)
                self.slider.addSubview(s)
            }
        }
    }
    
    fileprivate func positionOfPageAtIndex(_ index: Int) -> CGFloat {
        return self.frame.size.width*CGFloat(index) + self.frame.size.width - 32
    }
}

// MARK: - Scroll View Delegate

extension SNSlider: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        for i in 0..<data.count {
            data[i].updateMask(data[i].frame, newXPosition: positionOfPageAtIndex(i-1)-scrollView.contentOffset.x)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.x == positionOfPageAtIndex(-1)) {
            self.slider.scrollRectToVisible(CGRect(x: positionOfPageAtIndex(numberOfPages-1),y: 0,width: self.frame.width,height: self.frame.height), animated:false);
        }
        else if (scrollView.contentOffset.x == positionOfPageAtIndex(numberOfPages)) {
            self.slider.scrollRectToVisible(CGRect(x: positionOfPageAtIndex(0),y: 0,width: self.frame.width,height: self.frame.height), animated:false);
        }
    }
    
}
