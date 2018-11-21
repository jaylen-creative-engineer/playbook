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
    var apiUrl = "http://localhost:8080/users/"
    
    func createAccount(email : String, username : String, fullname : String, photoUrl : String, bio : String?){
        let url = apiUrl + "signup"

        var parameters = Alamofire.Parameters()
        parameters["email"] = email
        parameters["username"] = username
        parameters["fullname"] = fullname
        parameters["photoUrl"] = photoUrl
        parameters["bio"] = bio
        
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
    
    func socialLogin(email : String, fullname : String, photoUrl : String, completion: @escaping (User) -> ()){
        let url = "http://localhost:8080/signup"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
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
    func getAccountDetails(completion: @escaping (User) -> ()) {
        
        let url = "http://localhost:8080/users/user-details"
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let userResponse = try JSONDecoder().decode(User.self, from: data)
                completion(userResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    func getUserId(email : String, completion :  @escaping (User) -> ()){
        let url = apiUrl + "get-userid"
        
        var parameters = Alamofire.Parameters()
        parameters["email"] = email
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let userResponse = try JSONDecoder().decode(User.self, from: data)
                    completion(userResponse)
                    
                } catch let error {
                    print(error)
                }
                
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    func getAccount(completion: @escaping (User) -> ()) {
        let url = "http://localhost:8080/users/get_user_profile"
        
        let defaults = UserDefaults.standard
//        let userId = defaults.integer(forKey: "userId")
        
        let userId = 1
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let userResponse = try JSONDecoder().decode(User.self, from: data)
                    completion(userResponse)
                } catch let error {
                    print(error)
                }
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    func getUsersAdded(completion : @escaping (Added) -> ()) {
        let url = "http://localhost:8080/users/get_user_added"
        
        let defaults = UserDefaults.standard
//        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = 1
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let userResponse = try JSONDecoder().decode(Added.self, from: data)
                    completion(userResponse)
                } catch let error {
                    print(error)
                }
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    func getUsersPursuits(completion : @escaping ([Pursuit]) -> ()) {
        let url = "http://localhost:8080/users/get-user-pursuits"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = 1
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let userResponse = try JSONDecoder().decode([Pursuit].self, from: data)
                    completion(userResponse)
                } catch let error {
                    print(error)
                }
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    
    // MARK: - UPDATE user account info
    
    func updateAccount(username : String, fullname : String, photoUrl : String, bio : String){
        let url = "http://localhost:8080/users/update_signup"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        parameters["username"] = username
        parameters["fullname"] = fullname
        parameters["photoUrl"] = photoUrl
        parameters["bio"] = bio
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
        }
    }
    
    // MARK: - DELETE user account
    
    func deleteAccount(){
        let url = "http://localhost:8080/delete_account"
        
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
}
