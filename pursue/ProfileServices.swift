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
    var apiUrl = "https://arcane-mesa-59373.herokuapp.com"
    
    func createAccount(email : String?, username : String?, fullname : String?, photoUrl : String?, bio : String?, completion : @escaping () -> ()){
        let url = apiUrl + "/users/signup"

        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        parameters["email"] = email
        parameters["username"] = username
        parameters["fullname"] = fullname
        parameters["photoUrl"] = photoUrl
        parameters["bio"] = bio
        
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
    
    // MARK: - GET user account info
    func getAccountDetails(completion: @escaping (User) -> ()) {
        let url = apiUrl + "/users/user-details"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        
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
    
    func getAccount(completion: @escaping (User) -> ()) {
        let url = apiUrl + "/users/get_user_profile"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        
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
    
    func getForeigntAccount(userId : String, completion: @escaping (User) -> ()) {
        let url = apiUrl + "/users/get_user_profile"
        
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
    
    func getArrayOfProfilePost(pursuitId : Int?, completion: @escaping (HomeDetail) -> ()){
        let url = apiUrl + "/posts/profile_posts"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let homeResponse = try JSONDecoder().decode(HomeDetail.self, from: data)
                completion(homeResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    func getUsersAdded(completion : @escaping (Added) -> ()) {
        let url = apiUrl + "/users/get_user_added"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        
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
        let url = apiUrl + "/users/get-user-pursuits"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        
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
    
    func sendAddedUsers(pursuitId : Int?, userId : String?, is_following : Int?){
        let url = apiUrl + "/users/added-user"
        
        var parameters = Alamofire.Parameters()
        parameters["pursuitId"] = pursuitId
        parameters["is_following"] = is_following
        parameters["userId"] = userId
        
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
    
    
    // MARK: - UPDATE user account info
    
    func updateAccount(username : String, fullname : String, photoUrl : String, bio : String?){
        let url = apiUrl + "/users/update_signup"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
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
        let url = apiUrl + "/users/delete_account"
        
        var parameters = Alamofire.Parameters()
        parameters["userId"] = Auth.auth().currentUser?.uid
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
}
