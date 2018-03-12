//
//  HomeServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class HomeServices {
    
    // MARK: - GET pursuits by users interests
    
    func getPursuits(completion: @escaping (Pursuit, Steps, Principles) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/interest-pursuits"
        guard let userId = Auth.auth().currentUser?.uid else { return }

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
    
    func getUserPursuits(completion: @escaping (Pursuit, Post, Steps, Principles) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/user-pursuits"
        guard let userId = Auth.auth().currentUser?.uid else { return }

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
    
    func getPost(postId : String, completion: @escaping (Post) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/one_post"
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
    
    func getStep(stepId : String, completion: @escaping (Steps) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/one_step"
        var parameters = Alamofire.Parameters()
        parameters["stepId"] = stepId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    func getPrinciple(principleId : String, completion: @escaping (Principles) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/one_principle"
        var parameters = Alamofire.Parameters()
        parameters["principleId"] = principleId
        
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
