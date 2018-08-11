//
//  InterestService.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class InterestServices {
    
    // MARK: - POST interests lists
    
    var interestsNames = ["Academics", "Animals", "Beauty", "Business", "Cars", "Digital Design", "Fashion Design", "Food", "Graphic Design", "Health", "Interior Design", "Men Style", "Music", "Photography", "Productivity", "Self", "Sports", "Technology", "Travel", "Women Style"]
    var imageNames = ["academics", "animals", "beauty", "business", "cars", "digital-design", "fashion-design", "food", "graphic-design", "health", "interior-design", "mens-fashion", "music", "photography", "productivity", "self", "sports", "technology", "travel", "womens-fashion"]
    
    func createInterestsList(){
        for i in 0...interestsNames.count - 1 {
            guard let image = UIImage(named: imageNames[i])?.withRenderingMode(.alwaysOriginal) else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            let filename = NSUUID().uuidString
            let ref = Storage.storage().reference().child("interests-images").child(filename)
            ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload", err)
                }
                
                var interestsImageURL = ""
                ref.downloadURL(completion: { (url, error) in
                    if let error = error {
                        print(error)
                    } else {
                        let stringUrl = url?.absoluteString
                        interestsImageURL = stringUrl!
                    }
                })
                
                var parameters = Alamofire.Parameters()
                parameters["interestId"] = filename
                parameters["interest_name"] = self.interestsNames[i]
                parameters["interest_photo"] = interestsImageURL
                
                let url = "http://localhost:8080/interests"
                
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                }
                
            })
        }
    }
    
    // MARK: - GET interests lists
    
    func getSelectedInterests(userId : String, completion: @escaping ([Interests]) -> ()){
        let url = "http://localhost:8080/get-user-interests"
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId

        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let interestsResponse = try JSONDecoder().decode([Interests].self, from: data)
                completion(interestsResponse)
            } catch let error {
                print(error)
            }
            
        }
    }
    
    func getInterestsNames(completion: @escaping ([CreateInterests]) -> ()){
        let url = "http://localhost:8080/get-user-interests-names"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let interestsResponse = try JSONDecoder().decode([CreateInterests].self, from: data)
                completion(interestsResponse)
            } catch let error {
                print(error)
            }
            
        }
    }
}
