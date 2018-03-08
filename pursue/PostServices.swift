//
//  CreateServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostServices {
        
    // MARK: - CREATE pursuit
    
    func createPursuit(pursuitId : String, contentUrl : String, thumbnailUrl : String, is_visible : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["userId"] = userId
        parameters["contentUrl"] = contentUrl
        parameters["thumbnailUrl"] = thumbnailUrl
        parameters["is_visible"] = is_visible
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - ADD post to pursuit
    
    func addPostToPursuit(pursuitId : String, postId : String, contentUrl : String, thumbnailUrl : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["postId"] = postId
        parameters["userId"] = userId
        parameters["contentUrl"] = contentUrl
        parameters["thumbnailUrl"] = thumbnailUrl
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - UPDATE step/principle
    
    func updateStep(pursuitId : String, stepId : String, stepDescription : String, completion: @escaping (Steps) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["stepId"] = stepId
        parameters["stepDescription"] = stepDescription
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    func updatePrinciple(pursuitId : String, principleId : String, principleDescription : String, completion: @escaping (Principles) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["principleId"] = principleId
        parameters["principleDescription"] = principleDescription
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    // MARK: - DELETE pursuit
    
    func deletePursuit(pursuitId : String, completion: @escaping (Pursuit) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - DELETE post from pursuit
    
    func deletePostFromPursuit(postId : String, pursuitId : String, completion: @escaping (Post) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/"
        
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
}
