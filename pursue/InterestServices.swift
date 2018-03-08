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
    
    func createInterestsList(interestId: String){
        let url = "https://pursuit-jaylenhu27.c9users.io/"
        var parameters = Alamofire.Parameters()
        parameters["interestId"] = interestId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - GET interests lists
    
    func getSelectedInterests(completion: @escaping (Interests) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/user-interests"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
                }
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
}
