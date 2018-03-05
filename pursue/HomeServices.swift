//
//  HomeServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire

class HomeServices {
    
    // MARK: - GET pursuits by users interests
    
    func getPursuits(userId : String, completion: @escaping (Pursuit, Steps, Principles) -> ()){
        let url = ""
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - GET users pursuits
    
    func getUserPursuits(userId : String, completion: @escaping (Pursuit, Steps, Principles) -> ()){
        let url = ""
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - GET post by id
    
    func getPost(postId : String, completion: @escaping (Post, Steps, User, Principles, Comment) -> ()){
        let url = ""
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
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
