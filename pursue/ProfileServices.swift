//
//  ProfileServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class ProfileServices {
    
    // MARK: - CREATE account
    
    func createAccount(email : String, username : String, fullname : String, photoUrl : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/signup"
        guard let userId = Auth.auth().currentUser?.uid else { return }

        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        parameters["email"] = email
        parameters["username"] = username
        parameters["fullname"] = fullname
        parameters["photoUrl"] = photoUrl
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - GET user account info
    func getAccountDetails(completion: @escaping (User) -> ()) {
        let url = "https://pursuit-jaylenhu27.c9users.io/user"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let dictionary = response.result.value as? [String: Any] else { return }
                let user = User(dictionary: dictionary)
                completion(user)
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    
    func getAccount(completion: @escaping (User, Follower, Pursuit) -> ()) {
        let url = "https://pursuit-jaylenhu27.c9users.io/"
        guard let userId = Auth.auth().currentUser?.uid else { return }

        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        parameters["followerId"] = userId

        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let dictionary = response.result.value as? [String: Any] else { return }
                let user = User(dictionary: dictionary)
                // Don't use
                let follower = Follower(userPhoto: "random")
                let pursuit = Pursuit(user: user, dictionary: dictionary)
                completion(user, follower, pursuit)
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    
    // MARK: - UPDATE user account info
    
    func updateAccount(username : String, fullname : String, photoUrl : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/signup"
        guard let userId = Auth.auth().currentUser?.uid else { return }

        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        parameters["username"] = username
        parameters["fullname"] = fullname
        parameters["photoUrl"] = photoUrl
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
           
        }
    }
    
    // MARK: - DELETE user account
    
    func deleteAccount(){
        let url = "https://pursuit-jaylenhu27.c9users.io/delete_account"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
}
