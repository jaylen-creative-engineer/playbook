//
//  InterestsRows.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/23/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import SwiftyJSON

class InterestsRows : UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, SelectInterestsDelegate {
    
    let listId = "listId"
    
    let interestsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    var interestsNames = ["Academics", "Animals", "Beauty", "Business", "Cars", "Digital Design", "Fashion Design", "Food", "Graphic Design", "Health", "Interior Design", "Men Style", "Music", "Photography", "Productivity", "Self", "Sports", "Technology", "Travel", "Women Style"]
    var imageNames = ["academics", "animals", "beauty", "business", "cars", "digital-design", "fashion-design", "food", "graphic-design", "health", "interior-design", "mens-fashion", "music", "photography", "productivity", "self", "sports", "technology", "travel", "womens-fashion"]
    
    func createInterestsList(){
        
        for i in 0...interestsNames.count - 1 {
            guard let image = UIImage(named: imageNames[i])?.withRenderingMode(.alwaysOriginal) else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("interests-images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload", err)
                }
                
                guard let interestsImageURL = metadata?.downloadURL()?.absoluteString else { return }
                
                var parameters = Alamofire.Parameters()
                
                parameters["interestId"] = filename
                parameters["interest_name"] = self.interestsNames[i]
                parameters["interest_photo"] = interestsImageURL
                
                let url = "https://pursuit-jaylenhu27.c9users.io/interests"
                
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in                    
                    switch response.result {
                    case .success:
                        print("Success: \(response.result.isSuccess)")
                    case .failure:
                        print("Failure: \(response.result.isSuccess)")
                    }
                    
                }
                
            })
        }

    }
    
    var interests = [Interests]()
    var isVisible = [Bool]()
    
    func getSelectedInterests(){
        
        let url = "https://pursuit-jaylenhu27.c9users.io/user-interests"
        var parameters = Alamofire.Parameters()
        guard let userId = Auth.auth().currentUser?.uid else { return }
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let dictionaries = response.result.value as? [Dictionary<String,AnyObject>] else { return }
                for dictionary in dictionaries {
                    var interest = Interests(dictionary: dictionary)
                    if let value = dictionary["SelectedInterests"] as? Int, value == 1 {
                        interest.isSelected = true
                    } else {
                        interest.isSelected = false
                    }
                    self.interests.append(interest)
                    self.interestsCollection.reloadData()
                }
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    func didSelect(for cell: SelectInterestsList) {
        guard let indexPath = interestsCollection.indexPath(for: cell) else { return }
        var interest = self.interests[indexPath.item]
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        parameters["interestId"] = interest.interestId
        parameters["is_selected"] = (interest.isSelected == true ? 0 : 1)
        
        let url = "https://pursuit-jaylenhu27.c9users.io/user-interests"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
           
            interest.isSelected = !interest.isSelected
            self.interests[indexPath.item] = interest
            self.interestsCollection.reloadItems(at: [indexPath])
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width) / 3
        return CGSize(width: width + 45, height: (width - 20))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listId, for: indexPath) as! SelectInterestsList
        cell.delegate = self
        cell.interest = interests[indexPath.item]
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        interestsCollection.register(SelectInterestsList.self, forCellWithReuseIdentifier: listId)
        interestsCollection.delegate = self
        interestsCollection.dataSource = self
        addSubview(interestsCollection)
        interestsCollection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        getSelectedInterests()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
