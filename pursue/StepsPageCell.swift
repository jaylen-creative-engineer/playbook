//
//  StepsPageCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/3/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class StepsPageCell : UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            
            bearImageView.image = UIImage(named: unwrappedPage.imageName)
            descriptionTextView.text = page?.headerText
        }
    }
    
    private let bearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.init(25))
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(bearImageView)
        
        bearImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: (frame.height / 5) - 12, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 140, height: 90)
        addSubview(descriptionTextView)
        descriptionTextView.anchor(top: bearImageView.topAnchor, left: bearImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
