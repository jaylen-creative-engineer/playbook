//
//  PageCell.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/6/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {            
            guard let unwrappedPage = page else { return }
            
            imageView.image = UIImage(named: unwrappedPage.imageName)
            headerLabel.text = page?.headerText
            descriptionTextView.text = page?.bodyText
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let headerLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(imageView)
        addSubview(headerLabel)
        addSubview(descriptionTextView)
        
        imageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: (frame.height / 3.5), paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 250)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        headerLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: headerLabel.intrinsicContentSize.width, height: 26)
        headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionTextView.anchor(top: headerLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
