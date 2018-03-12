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

class CreateServices {
    
    // MARK: - CREATE pursuit
    
    func createPursuit(pursuitId : String, interestId : String, contentUrl : String, thumbnailUrl : String, pursuitDescription : String, is_visible : Int, is_public : Int){
        let url = "https://pursuit-jaylenhu27.c9users.io/create_pursuit"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["userId"] = userId
        parameters["interestId"] = interestId
        parameters["contentUrl"] = contentUrl
        parameters["thumbnailUrl"] = thumbnailUrl
        parameters["is_visible"] = is_visible
        parameters["is_public"] = is_public
        parameters["pursuitDescription"] = pursuitDescription
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    // MARK: - GET users pursuits
    
    func getUserPursuits(completion: @escaping (Pursuit) -> ()){
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
    
    // MARK: - ADD post to pursuit
    
    func addPostToPursuit(pursuitId : String, interestId : String, postId : String, contentUrl : String, thumbnailUrl : String, is_visible : Int, is_public : Int){
        let url = "https://pursuit-jaylenhu27.c9users.io/create_post"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["postId"] = postId
        parameters["interestId"] = interestId
        parameters["userId"] = userId
        parameters["contentUrl"] = contentUrl
        parameters["thumbnailUrl"] = thumbnailUrl
        parameters["is_visible"] = is_visible
        parameters["is_public"] = is_public

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    func addStepToPursuit(pursuitId : String, interestId : String, stepId : String, contentUrl : String, thumbnailUrl : String, stepDescription : String, is_visible : Int, is_public : Int){
        let url = "https://pursuit-jaylenhu27.c9users.io/create_step"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["stepId"] = stepId
        parameters["interestId"] = interestId
        parameters["userId"] = userId
        parameters["stepDescription"] = stepDescription
        parameters["contentUrl"] = contentUrl
        parameters["thumbnailUrl"] = thumbnailUrl
        parameters["is_visible"] = is_visible
        parameters["is_public"] = is_public
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    func addPrincipleToPursuit(pursuitId : String, interestId : String, principleId : String, contentUrl : String, thumbnailUrl : String, principleDescription : String, is_visible : Int, is_public : Int){
        let url = "https://pursuit-jaylenhu27.c9users.io/create_principle"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["principleId"] = principleId
        parameters["interestId"] = interestId
        parameters["userId"] = userId
        parameters["principleDescription"] = principleDescription
        parameters["contentUrl"] = contentUrl
        parameters["thumbnailUrl"] = thumbnailUrl
        parameters["is_visible"] = is_visible
        parameters["is_public"] = is_public
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    // MARK: - UPDATE step/principle
    
    func updateStep(pursuitId : String, stepId : String, interestId : String, stepDescription : String, completion: @escaping (Steps) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/create_step"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["stepId"] = stepId
        parameters["interestId"] = interestId
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
    
    func updatePrinciple(pursuitId : String, principleId : String, interestId : String, principleDescription : String, completion: @escaping (Principles) -> ()){
        let url = "https://pursuit-jaylenhu27.c9users.io/create_principle"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["interestId"] = interestId
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
    
    func deletePursuit(pursuitId : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/delete_pursuit"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
           // Hide pursuit
        }
    }
    
    // MARK: - DELETE post from pursuit
    
    func deletePostFromPursuit(postId : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/delete_post"
        
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            // Remove post
        }
    }
}
