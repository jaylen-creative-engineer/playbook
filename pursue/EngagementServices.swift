//
//  EngagementServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire

class EngagementServices {
    
    // MARK: - COMMENT ON step/principle/pursuit
    
    func commentOnPursuit(pursuitId : String, completion: @escaping (Comment) -> ()){
        let url = ""
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
    
    // MARK: - DELETE COMMENT FROM step/principle/pursuit
    
    func deleteCommentFromPursuit(pursuitId : String, completion: @escaping (Comment) -> ()){
        let url = ""
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
    
    // MARK: - SELECT video at id
    
    func selectVideoAtId(postId : String, completion: @escaping (Post) -> ()){
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
    
    // MARK: - TOGGLE saving step
    
    func toggleSaveStep(postId : String, completion: @escaping (Engagements) -> ()) {
        let url = ""
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - TOGGLE saving principles
    
    func toggleSavePrinciple(postId : String, completion: @escaping (Engagements) -> ()) {
        let url = ""
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - TOOGLE like step/principle/pursuit
    
    func togglePostLike(postId : String, completion: @escaping (Engagements) -> ()) {
        let url = ""
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - TOGGLE follow interests
    
    func toggleFollowInterests(interestId : String, completion: @escaping (Interests) -> ()) {
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
    
    // MARK: - TOGGLE follow user
    
    func toggleFollowUser(userId : String, completion: @escaping (User) -> ()){
        let url = ""
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }

    // MARK: - TOGGLE follow pursuit
    
    func toggleFollowPursuit(pursuitId : String, completion: @escaping (Pursuit) -> ()){
        let url = ""
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
    
}
