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
import SwiftyJSON

class ProfileServices {
    
    // MARK: - CREATE account
    
    func createAccount(email : String, username : String, fullname : String, photoUrl : String, bio : String?){
        let url = "http://localhost:8080/signup"
        guard let userId = Auth.auth().currentUser?.uid else { return }

        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        parameters["email"] = email
        parameters["username"] = username
        parameters["fullname"] = fullname
        parameters["photoUrl"] = photoUrl
        parameters["bio"] = bio
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    func socialLogin(email : String, fullname : String, photoUrl : String, completion: @escaping (User) -> ()){
        let url = "http://localhost:8080/signup"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        parameters["email"] = email
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
    func getAccountDetails(completion: @escaping (UserDetails) -> ()) {
        let url = "http://localhost:8080/user-details"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let userResponse = try JSONDecoder().decode(UserDetails.self, from: data)
                completion(userResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    func getAccount(completion: @escaping (User) -> ()) {
        let url = "http://localhost:8080/user-profile"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                var userData : User?
                let userResponse = try JSONDecoder().decode([User].self, from: data)
                userResponse.forEach({ (user) in
                    userData = user
                })
                
                guard let userValues = userData else { return }
                completion(userValues)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    // MARK: - UPDATE user account info
    
    func updateAccount(username : String, fullname : String, photoUrl : String){
        let url = "http://localhost:8080/signup"
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
        let url = "http://localhost:8080/delete_account"
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
}
