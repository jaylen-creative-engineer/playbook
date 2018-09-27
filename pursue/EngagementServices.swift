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
    
    // MARK: - COMMENT ON step/principle/pursuit    
    func commentOnPost(postId : String, commentId : String, comment_text : String, completion: @escaping (PostComment) -> ()){
        let url = "http://localhost:8080/posts_comments"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        parameters["userId"] = userId
        parameters["commentId"] = commentId
        parameters["comment_text"] = comment_text
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    func commentOnPrinciple(principleId : String, commentId : String, comment_text : String, completion: @escaping (PrincipleComment) -> ()){
        let url = "http://localhost:8080/principles_comments"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["principleId"] = principleId
        parameters["userId"] = userId
        parameters["commentId"] = commentId
        parameters["comment_text"] = comment_text
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    func commentOnStep(stepId : String, commentId : String, comment_text : String, completion: @escaping (StepsComment) -> ()){
        let url = "http://localhost:8080/steps_comments"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["stepId"] = stepId
        parameters["userId"] = userId
        parameters["commentId"] = commentId
        parameters["comment_text"] = comment_text
        
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
    
    func deleteCommentFromPost(commentId : String, completion: @escaping (PostComment) -> ()){
        let url = "http://localhost:8080/remove_post_comment"
        var parameters = Alamofire.Parameters()
        parameters["commentId"] = commentId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            // Remove item from array
        }
    }
    
    func deleteCommentFromStep(commentId : String, completion: @escaping (StepsComment) -> ()){
        let url = "http://localhost:8080/remove_step_comment"
        var parameters = Alamofire.Parameters()
        parameters["commentId"] = commentId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            // Remove item from array
            
        }
    }
    
    func deleteCommentFromPrinciple(commentId : String, completion: @escaping (PrincipleComment) -> ()){
        let url = "http://localhost:8080/remove_principle_comment"
        var parameters = Alamofire.Parameters()
        parameters["commentId"] = commentId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            // Remove item from array
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
