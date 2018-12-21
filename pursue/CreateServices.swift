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
import FirebaseStorage
import FirebaseAuth

class CreateServices {
    
    var apiUrl = "https://arcane-mesa-59373.herokuapp.com"
    
    // MARK: - CREATE pursuit
    
    func createPursuit(interestId : Int?, thumbnailUrl : UIImage?, pursuitDescription : String?, is_public : Int, completion : @escaping () -> ()){
        let url = apiUrl + "/pursuits/create_pursuit"

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
                    parameters["userId"] = Auth.auth().currentUser?.uid
                    parameters["interestId"] = interestId
                    parameters["thumbnailUrl"] = thumbnailUrl
                    parameters["is_public"] = is_public
                    parameters["pursuit_description"] = pursuitDescription
                    parameters["is_visible"] = 1
                    parameters["is_tried"] = 0
                    
                    Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                        print(response.result)
                    })
                    
                    completion()
                }
            })

        })
    }
    
    func createPost(pursuitId : Int, contentUrl : URL?, thumbnailUrl : UIImage?, posts_description : String?, is_keyPost: Int, is_public : Int){
        let url = apiUrl + "/posts/create_post"
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
                    if contentUrl?.absoluteString != nil {
                            self.uploadVideo(contentUrl: contentUrl!, completion: { (videoUrl) in
                                parameters["videoUrl"] = videoUrl
                                parameters["thumbnailUrl"] = thumbnailUrl
                                parameters["userId"] = Auth.auth().currentUser?.uid
                                parameters["is_visible"] = 1
                                parameters["is_keyPost"] = is_keyPost
                                parameters["is_public"] = is_public
                                parameters["is_saved"] = 0
                                parameters["is_response"] = 0
                                
                                Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                                    print(response.result)
                                })
                            })
                       
                    } else if contentUrl?.absoluteString == nil {
                        parameters["videoUrl"] = nil
                        parameters["thumbnailUrl"] = thumbnailUrl
                        parameters["userId"] = Auth.auth().currentUser?.uid
                        parameters["is_visible"] = 1
                        parameters["is_keyPost"] = is_keyPost
                        parameters["is_public"] = is_public
                        parameters["is_saved"] = 0
                        parameters["is_response"] = 0
                        
                        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                            print(response.result)
                        })
                    }
                    
                }
            })
        })
    }
    
    func uploadVideo(contentUrl : URL, completion: @escaping (URL?) -> Void) {
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("videos").child(filename)
        
        ref.putFile(from: contentUrl, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Failed to upload", err)
            }
            
            ref.downloadURL(completion: { (videoUrl, error) in
                if let error = error {
                    print(error)
                }
                completion(videoUrl)
            })
        }
    }
    
    func addTeam(pursuitId : Int?, userId : String?){
        let url = apiUrl + "/engagements/add_team"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["userId"] = userId
        parameters["is_following"] = 1
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print(response.result)
        })
    }
    
    func submitBlock(friendId : String?){
        let url = apiUrl + "/users/block_user"
        
        var parameters = Alamofire.Parameters()
        parameters["blockerId"] = Auth.auth().currentUser?.uid
        parameters["blockeeId"] = friendId
        parameters["is_blocked"] = 1
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print(response.result)
        })
    }
    
    func unblockUser(friendId : String?){
        let url = apiUrl + "/users/delete_post"
        
        var parameters = Alamofire.Parameters()
        parameters["blockerId"] = Auth.auth().currentUser?.uid
        parameters["blockeeId"] = friendId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print(response.result)
        })
    }
    
    func getBlockStatus(friendId : String?, completion: @escaping (User) -> ()){
        let url = apiUrl + "/users/get_block_status"
        
        var parameters = Alamofire.Parameters()
        parameters["blockerId"] = Auth.auth().currentUser?.uid
        parameters["blockeeId"] = friendId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let userResponse = try JSONDecoder().decode(User.self, from: data)
                completion(userResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - GET users pursuits
    
    func getUserPostId(pursuitId : Int, completion: @escaping (Post) -> ()){
        let url = apiUrl + "/posts/get_postId"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let postResponse = try JSONDecoder().decode(Post.self, from: data)
                completion(postResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    func getUserPursuitsId(completion: @escaping (Pursuit) -> ()){
        let url = apiUrl + "/pursuits/get_pursuitIds"

        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let pursuitResponse = try JSONDecoder().decode(Pursuit.self, from: data)
                completion(pursuitResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    func getCreateDetail(completion: @escaping (CreateDetail) -> ()){
        let url = apiUrl + "/posts/get_create_details"

        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let createResponse = try JSONDecoder().decode(CreateDetail.self, from: data)
                completion(createResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - ADD post to pursuit
    
    func savePost(pursuitId : Int, videoUrl : String?, thumbnailUrl : String?, posts_description : String?) {
        let url = apiUrl + "/posts/create_post"

        var parameters = Alamofire.Parameters()
        parameters["posts_description"] = posts_description
        parameters["userId"] = Auth.auth().currentUser?.uid
        parameters["pursuitId"] = pursuitId
        parameters["videoUrl"] = videoUrl
        parameters["thumbnailUrl"] = thumbnailUrl
        parameters["is_visible"] = 1
        parameters["is_keyPost"] = 0
        parameters["is_public"] = 1
        
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
    
    func sendToResponses(pursuitId : Int?, postId : Int?) {
        let url = apiUrl + "/posts/create_responses_ids"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        parameters["pursuitId"] = pursuitId
        parameters["postId"] = postId
        
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
    
    func sendToSimilarPursuit(new_pursuitId : Int?, pursuitId : Int?) {
        let url = apiUrl + "/pursuits/similar_pursuit"
        
        var parameters = Alamofire.Parameters()
        parameters["new_pursuitId"] = new_pursuitId
        parameters["pursuitId"] =  pursuitId
        
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

    
    func sendTry(pursuit_description : String?, thumbnailUrl : String?, interestId : Int?, pursuitId : Int?, completion : @escaping () -> ()) {
        let url = apiUrl + "/pursuits/try_pursuit"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuit_description"] = pursuit_description
        parameters["userId"] = Auth.auth().currentUser?.uid
        parameters["interestId"] = interestId
        parameters["thumbnailUrl"] = thumbnailUrl
        parameters["old_pursuitId"] =  pursuitId
        parameters["is_visible"] = 1
        parameters["is_public"] = 1
        parameters["is_tried"] = 1
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
                completion()
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                completion()
                debugPrint(error as Any)
                print("===========================\n\n")
            }
        }
    }
}
