//
//  SearchPopAnimatino.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class SearchPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 3.0
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (()->Void)?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: .to)!
        
        containerView.addSubview(toView)
        toView.alpha = 0.0
        UIView.animate(withDuration: duration,
                       animations: {
                        
                        toView.alpha = 1.0
        },
                       completion: { _ in
                        transitionContext.completeTransition(true)
        }
        )
        
//        let containerView = transitionContext.containerView
//        let toView = transitionContext.view(forKey: .to)!
//        let searchView = presenting ? toView : transitionContext.view(forKey: .from)!
//
//        let initialFrame = presenting ? originFrame : searchView.frame
//        let finalFrame = presenting ? searchView.frame : originFrame
//
//        let xScaleFactor = presenting ?
//            initialFrame.width / finalFrame.width :
//            finalFrame.width / initialFrame.width
//
//        let yScaleFactor = presenting ?
//            initialFrame.height / finalFrame.height :
//            finalFrame.height / initialFrame.height
//        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
//
//        if presenting {
//            searchView.transform = scaleTransform
//            searchView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
//            searchView.clipsToBounds = true
//        }
//
//        containerView.addSubview(toView)
//        containerView.bringSubview(toFront: searchView)
//        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
//            searchView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
//            searchView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
//        }) { (_) in
//            if !self.presenting {
//                self.dismissCompletion?()
//            }
//            transitionContext.completeTransition(true)
//        }

        
    }
}
