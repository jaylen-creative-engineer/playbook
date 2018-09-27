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
import FirebaseStorage

class InterestServices {
    
    // MARK: - POST interests lists
    
    var interestsNames = ["Academics", "Animals", "Beauty", "Business", "Cars", "Digital Design", "Fashion Design", "Food", "Graphic Design", "Health", "Interior Design", "Men Style", "Music", "Photography", "Productivity", "Self", "Sports", "Technology", "Travel", "Women Style"]
    var imageNames = [#imageLiteral(resourceName: "academics"), #imageLiteral(resourceName: "animals"), #imageLiteral(resourceName: "beauty"), #imageLiteral(resourceName: "business"), #imageLiteral(resourceName: "cars"), #imageLiteral(resourceName: "digital-design"), #imageLiteral(resourceName: "fashion-design"), #imageLiteral(resourceName: "food"), #imageLiteral(resourceName: "graphic-design"), #imageLiteral(resourceName: "health"), #imageLiteral(resourceName: "interior-design"), #imageLiteral(resourceName: "mens-fashion"), #imageLiteral(resourceName: "music"), #imageLiteral(resourceName: "photography"), #imageLiteral(resourceName: "productivity"), #imageLiteral(resourceName: "self"), #imageLiteral(resourceName: "sports"), #imageLiteral(resourceName: "technology"),#imageLiteral(resourceName: "travel"), #imageLiteral(resourceName: "womens-fashion")]
    
    func createInterestsList(){
        for i in 0...interestsNames.count - 1 {
            let image = imageNames[i]
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
                        
                        var parameters = Alamofire.Parameters()
                        parameters["interest_name"] = self.interestsNames[i]
                        parameters["interest_photo"] = interestsImageURL
                        
                        let url = "http://localhost:8080/interests/create-interests"
                        
                        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                            print(response.result)
                        })
                    }
                })
                
            })
        }
    }
    
    // MARK: - GET interests lists
    
    func getSelectedInterests(completion: @escaping ([Interests]) -> ()){
        let url = "http://localhost:8080/interests/get-user-interests"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
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
        let url = "http://localhost:8080/interests/get-user-interests-names"
        
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
