//
//  EngagementServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth

class EngagementServices {
    
    var apiUrl = "https://arcane-mesa-59373.herokuapp.com/"
    
    func getSaveStatus(postId : Int, completion: @escaping (Engagements) -> ()){
        let url = "http://localhost:8080/engagements/get_save_status"
        let defaults = UserDefaults.standard
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = defaults.integer(forKey: "userId")
        parameters["postId"] = postId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let enagementResponse = try JSONDecoder().decode(Engagements.self, from: data)
                completion(enagementResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    func getTrystatus(pursuitId : Int, completion: @escaping (Engagements) -> ()){
        let url = "http://localhost:8080/engagements/get_try_status"
        let defaults = UserDefaults.standard
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = defaults.integer(forKey: "userId")
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let enagementResponse = try JSONDecoder().decode(Engagements.self, from: data)
                completion(enagementResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - TOGGLE saving step
    
    func toggleSaveStep(stepId : String, pursuitId : String, is_saved : Int) {
        let url = "http://localhost:8080/step_saved"
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["stepId"] = stepId
        parameters["is_saved"] = is_saved
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    func toggleSavePost(postId : String, pursuitId : String, is_saved : Int) {
        let url = "http://localhost:8080/post_saved"
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["postId"] = postId
        parameters["is_saved"] = is_saved
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    func toggleSavePrinciple(principleId : String, pursuitId : String) {
        let url = "http://localhost:8080/principle_saved"
        var parameters = Alamofire.Parameters()
        parameters["principleId"] = principleId
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
        }
    }
    
    // MARK: - TOOGLE like step/principle/pursuit
    
    func togglePostLike(postId : String, is_liked : Int) {
        let url = "http://localhost:8080/post_liked"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        parameters["userId"] = userId
        parameters["is_liked"] = is_liked
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    func togglePrincipleLike(principleId : String, is_liked : Int) {
        let url = "http://localhost:8080/principle_liked"
      
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["principleId"] = principleId
        parameters["userId"] = userId
        parameters["is_liked"] = is_liked
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    func toggleStepLike(stepId : String, is_liked : Int) {
        let url = "http://localhost:8080/step_liked"
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["stepId"] = stepId
        parameters["userId"] = userId
        parameters["is_liked"] = is_liked
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
    
    // MARK: - TOGGLE follow interests
    
    func toggleFollowInterests(interestId : Int, is_selected : Int) {
        let url = "http://localhost:8080/interests/toggle-user-interests"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        print(userId)
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        parameters["interestId"] = interestId
        parameters["is_selected"] = is_selected
        
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
    
    func toggleFollowUser(followeeId : Int, is_following : Int, completion: @escaping (User) -> ()){
        let url = "http://localhost:8080/follow_user"
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")

        var parameters = Alamofire.Parameters()
        parameters["followerId"] = userId
        parameters["followeeId"] = followeeId
        parameters["is_following"] = is_following
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }

    // MARK: - TOGGLE follow pursuit
    
    func toggleFollowPursuit(pursuitId : Int, is_following : Int, completion: @escaping (Pursuit) -> ()){
        let url = "http://localhost:8080/follow_pursuit"
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["userId"] = userId
        parameters["is_following"] = is_following
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
        }
    }
    
}
