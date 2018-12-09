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
    
    var apiUrl = "https://arcane-mesa-59373.herokuapp.com"
    
    func getSaveStatus(postId : Int?, completion: @escaping (Engagements) -> ()){
        let url = apiUrl + "/engagements/get_save_status"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
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
    
    func getTrystatus(pursuitId : Int?, completion: @escaping (Engagements) -> ()){
        let url = apiUrl + "/engagements/get_try_status"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
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
    
    func toggleSave(postId : Int, is_saved : Int) {
        let url = apiUrl + "/engagements/post-saved"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        parameters["postId"] = postId
        parameters["is_saved"] = is_saved
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
            }
        }
    }
    
    func toggleTry(pursuitId : Int?, is_tried : Int) {
        let url = apiUrl + "/engagements/pursuit_tried"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["userId"] = Auth.auth().currentUser?.uid
        parameters["is_tried"] = is_tried
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
            }
        }
    }
    
    
    
    // MARK: - TOGGLE follow interests
    
    func toggleFollowInterests(interestId : Int, is_selected : Int) {
        let url = apiUrl + "/interests/toggle-user-interests"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
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
    
    func createResponse(pursuitId : Int?, contentUrl : URL?, thumbnailUrl : UIImage?, posts_description : String?, is_public : Int){
        let url = apiUrl + "/posts/create_responses"

        guard let uploadData = thumbnailUrl?.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("pursuit-images").child(filename)
        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            ref.downloadURL(completion: { (thumbnailUrl, error) in
                if let error = error {
                    print(error)
                } else {
                    
                    var parameters = Alamofire.Parameters()
                    parameters["posts_description"] = posts_description
                    parameters["pursuitId"] = pursuitId
                    parameters["userId"] = Auth.auth().currentUser?.uid
                    parameters["videoUrl"] = contentUrl
                    parameters["thumbnailUrl"] = thumbnailUrl
                    parameters["is_public"] = 1
                    parameters["is_visible"] = 1
                    parameters["is_keyPost"] = 0
                    parameters["is_public"] = 1
                    parameters["is_response"] = 1
                    parameters["is_saved"] = 0
                    
                    Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                        print(response.result)
                    })
                }
            })
        })
    }
    
    // MARK: - TOGGLE follow user
    
    func toggleFollowUser(followeeId : Int, is_following : Int){
        let url = apiUrl + "/users/follow_user"

        var parameters = Alamofire.Parameters()

        parameters["followerId"] = Auth.auth().currentUser?.uid
        parameters["followeeId"] = followeeId
        parameters["is_following"] = is_following
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
            }
        }
    }
    
}
