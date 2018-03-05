//
//  CreateServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire

class PostServices {
        
    // MARK: - CREATE pursuit
    
    func createPursuit(pursuitId : String, completion: @escaping (Pursuit) -> ()){
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
    
    // MARK: - ADD post to pursuit
    
    func addPostToPursuit(pursuitId : String){
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
    
    // MARK: - UPDATE step/principle
    
    func updateStep(pursuitId : String, completion: @escaping (Steps) -> ()){
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
    
    func updatePrinciple(pursuitId : String, completion: @escaping (Principles) -> ()){
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
    
    // MARK: - DELETE pursuit
    
    func deletePursuit(pursuitId : String){
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
    
    // MARK: - DELETE post from pursuit
    
    func deletePostFromPursuit(pursuitId : String, completion: @escaping (Post) -> ()){
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
