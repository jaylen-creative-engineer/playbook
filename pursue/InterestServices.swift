//
//  InterestService.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire

class InterestServices {
    
    // MARK: - POST interests lists
    
    func createInterestsList(interestId: String){
        let url = ""
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
    
    func getSelectedInterests(interestId: String, completion: @escaping (Interests) -> ()){
        let url = ""
        var parameters = Alamofire.Parameters()
        parameters["interestId"] = interestId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
}
