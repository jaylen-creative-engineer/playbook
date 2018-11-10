//
//  HomeServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class HomeServices {
    
    // MARK: - GET pursuits by users interests
    
    func getHomeFeed(completion: @escaping ([Home]) -> ()){
        let url = "http://localhost:8080/posts/get_home_feed"

        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let homeResponse = try JSONDecoder().decode([Home].self, from: data)
                completion(homeResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    func getHomeDetail(pursuitId : Int, completion: @escaping (HomeDetail) -> ()){
        let url = "http://localhost:8080/posts/get_post_details"
        let defaults = UserDefaults.standard
      
        var parameters = Alamofire.Parameters()
        parameters["userId"] = defaults.integer(forKey: "userId")
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
    
    func getPursuits(completion: @escaping ([Home]) -> ()){
        let url = "http://localhost:8080/interest-pursuits"
       
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")

        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let homeResponse = try JSONDecoder().decode([Home].self, from: data)
                completion(homeResponse)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - GET users pursuits
    
    func getUserPursuits(completion: @escaping (Pursuit, Post) -> ()){
        let url = "http://localhost:8080/user-pursuits"
        let defaults = UserDefaults.standard
        let userId = defaults.integer(forKey: "userId")

        var parameters = Alamofire.Parameters()
        parameters["userId"] = userId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - GET post by id
    
    func getPost(postId : String, completion: @escaping (Post) -> ()){
        let url = "http://localhost:8080/one_post"
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
}
