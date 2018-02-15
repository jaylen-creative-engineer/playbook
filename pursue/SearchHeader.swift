//
//  SearchHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/14/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire

class SearchHeader : UICollectionViewCell, UITextFieldDelegate {
    var accessSearchController : SearchController?
    
    lazy var searchBar : UITextField = {
        let tv = UITextField()
        tv.font = UIFont.boldSystemFont(ofSize: 24)
        tv.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 24)])
        tv.textColor = .black
        tv.isUserInteractionEnabled = true
        tv.delegate = self
        return tv
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    @objc func goBack(){
        accessSearchController?.goBack()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backButton)
        addSubview(searchBar)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        searchBar.anchor(top: backButton.topAnchor, left: backButton.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 12, width: 0, height: searchBar.intrinsicContentSize.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchController  {
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//
//        guard let searchText = searchBar.text else { return }
//        getSearchContent(searchText: searchText)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            print("Search is empty")
//        } else {
//            getSearchContent(searchText: searchText)
//        }
//    }
    
    func getSearchContent(searchText : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/search"
        var parameters = Alamofire.Parameters()
        parameters["searchField"] = searchText
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let dictionaries = response.result.value as? [Dictionary<String,AnyObject>] else { return }
                
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
}
