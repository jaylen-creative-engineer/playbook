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
    
    // MARK: - CREATE pursuit
    
    func createPursuit(pursuitId : String, postId : String, interestId : String, contentUrl : String?, thumbnailUrl : UIImage, pursuitDescription : String?, is_step: Int, is_principle : Int, is_visible : Int, is_public : Int){
        let url = "http://localhost:8080/create_pursuit"
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        guard let uploadData = thumbnailUrl.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("pursuit-images").child(filename)
        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            var pursuitImage : URL?
            
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    print(error)
                } else {
                    pursuitImage = url
                }
            })
        
            var parameters = Alamofire.Parameters()
            parameters["pursuitId"] = pursuitId
            parameters["userId"] = userId
            parameters["interestId"] = interestId
            parameters["contentUrl"] = contentUrl
            parameters["thumbnailUrl"] = pursuitImage
            parameters["is_visible"] = is_visible
            parameters["is_public"] = is_public
            parameters["is_step"] = is_step
            parameters["is_principle"] = is_principle
            parameters["pursuitDescription"] = pursuitDescription
            parameters["postId"] = postId
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            }
        })
    }
    
    func createPrinciplePursuit(pursuitId : String, principleId : String, interestId : String, contentUrl : String?, thumbnailUrl : UIImage, pursuitDescription : String?, is_step: Int, is_principle : Int, is_visible : Int, is_public : Int){
        let url = "http://localhost:8080/create_pursuit_principle"
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        guard let uploadData = thumbnailUrl.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("pursuit-images").child(filename)
        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            var pursuitImage : URL?
            
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    print(error)
                } else {
                    pursuitImage = url
                }
            })
            
            var parameters = Alamofire.Parameters()
            parameters["pursuitId"] = pursuitId
            parameters["userId"] = userId
            parameters["interestId"] = interestId
            parameters["contentUrl"] = contentUrl
            parameters["thumbnailUrl"] = pursuitImage
            parameters["is_visible"] = is_visible
            parameters["is_public"] = is_public
            parameters["is_step"] = is_step
            parameters["is_principle"] = is_principle
            parameters["pursuitDescription"] = pursuitDescription
            parameters["principleId"] = principleId
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            }
        })
    }
    
    
    func createStepPursuit(pursuitId : String, stepId : String, interestId : String, contentUrl : String?, thumbnailUrl : UIImage, pursuitDescription : String?, is_step: Int, is_principle : Int, is_visible : Int, is_public : Int){
        let url = "http://localhost:8080/create_pursuit_step"
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        guard let uploadData = thumbnailUrl.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("pursuit-images").child(filename)
        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            var pursuitImage : URL?
            
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    print(error)
                } else {
                    pursuitImage = url
                }
            })
            
            var parameters = Alamofire.Parameters()
            parameters["pursuitId"] = pursuitId
            parameters["userId"] = userId
            parameters["interestId"] = interestId
            parameters["contentUrl"] = contentUrl
            parameters["thumbnailUrl"] = pursuitImage
            parameters["is_visible"] = is_visible
            parameters["is_public"] = is_public
            parameters["is_step"] = is_step
            parameters["is_principle"] = is_principle
            parameters["pursuitDescription"] = pursuitDescription
            parameters["stepId"] = stepId
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            }
        })
    }
    
    // MARK: - GET users pursuits
    
    func getUserPursuits(completion: @escaping (Pursuit) -> ()){
        let url = "http://localhost:8080/user-create-pursuits"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                var pursuitData : Pursuit?
                let pursuitResponse = try JSONDecoder().decode([Pursuit].self, from: data)
                pursuitResponse.forEach({ (pursuit) in
                    pursuitData = pursuit
                })
                
                guard let pursuitValues = pursuitData else { return }
                completion(pursuitValues)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - ADD post to pursuit
    
    func addPostToPursuit(pursuitId : String, interestId : String, postId : String, contentUrl : String, thumbnailUrl : UIImage, is_step : Int, is_principle : Int){
        let url = "http://localhost:8080/create_post"
        
        guard let uploadData = thumbnailUrl.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("pursuit-images").child(filename)
        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            var postImageUrl : URL?
            
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    print(error)
                } else {
                    postImageUrl = url
                }
            })
            
            guard let userId = Auth.auth().currentUser?.uid else { return }
            
            var parameters = Alamofire.Parameters()
            parameters["pursuitId"] = pursuitId
            parameters["postId"] = postId
            parameters["interestId"] = interestId
            parameters["userId"] = userId
            parameters["contentUrl"] = contentUrl
            parameters["thumbnailUrl"] = postImageUrl
            parameters["is_step"] = is_step
            parameters["is_principle"] = is_principle
            parameters["is_visible"] = 1
            parameters["is_public"] = 1
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            }
            
        })
        
    }
    
    func addStepToPursuit(pursuitId : String, interestId : String, stepId : String, contentUrl : String, thumbnailUrl : UIImage, stepDescription : String, is_visible : Int, is_public : Int){
        
        let url = "http://localhost:8080/create_step"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        guard let uploadData = thumbnailUrl.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("pursuit-images").child(filename)
        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            var postImageUrl : URL?
            
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    print(error)
                } else {
                    postImageUrl = url
                }
            })

            var parameters = Alamofire.Parameters()
            parameters["pursuitId"] = pursuitId
            parameters["stepId"] = stepId
            parameters["interestId"] = interestId
            parameters["userId"] = userId
            parameters["stepDescription"] = stepDescription
            parameters["contentUrl"] = contentUrl
            parameters["thumbnailUrl"] = postImageUrl
            parameters["is_visible"] = is_visible
            parameters["is_public"] = is_public
        
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            }
        })
    }
    
    func addPrincipleToPursuit(pursuitId : String, interestId : String, principleId : String, contentUrl : String, thumbnailUrl : UIImage, principleDescription : String, is_visible : Int, is_public : Int){
        let url = "http://localhost:8080/create_principle"
        guard let uploadData = thumbnailUrl.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("pursuit-images").child(filename)
        ref.putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
                print("Failed to upload", err)
            }
            
            guard let userId = Auth.auth().currentUser?.uid else { return }
            var postImageUrl : URL?
            
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    print(error)
                } else {
                    postImageUrl = url
                }
            })

            var parameters = Alamofire.Parameters()
            parameters["pursuitId"] = pursuitId
            parameters["principleId"] = principleId
            parameters["interestId"] = interestId
            parameters["userId"] = userId
            parameters["principleDescription"] = principleDescription
            parameters["contentUrl"] = contentUrl
            parameters["thumbnailUrl"] = postImageUrl
            parameters["is_visible"] = is_visible
            parameters["is_public"] = is_public
        
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            }
        })
    }
    
    // MARK: - UPDATE step/principle
    
    func updateStep(pursuitId : String, stepId : String, interestId : String, stepDescription : String, completion: @escaping (Steps) -> ()){
        let url = "http://localhost:8080/create_step"
        
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
        let url = "http://localhost:8080/create_principle"
        
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
        let url = "http://localhost:8080/delete_pursuit"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
           // Hide pursuit
        }
    }
    
    // MARK: - DELETE post from pursuit
    
    func deletePostFromPursuit(postId : String){
        let url = "http://localhost:8080/delete_post"
        
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            // Remove post
        }
    }
}
