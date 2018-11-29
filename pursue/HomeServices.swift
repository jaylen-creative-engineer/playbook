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
    
    func getPostCount(completion: @escaping ([Home]) -> ()){
        let url = "http://localhost:8080/posts/get_post_count"
        
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
    
    func getArrayOfPost(postId : Int?, pursuitId : Int?, completion: @escaping (HomeDetail) -> ()){
        let url = "http://localhost:8080/posts/array_of_posts"
        
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
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
    
    
    func getMorePostForHomeFeed(postId : Int?, completion: @escaping ([Home]) -> ()){
        let url = "http://localhost:8080/posts/get_more_post"
        
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
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
    
    func refreshHomeFeed(postId : Int?, completion: @escaping ([Home]) -> ()){
        let url = "http://localhost:8080/posts/get_refresh_feed"
        
        var parameters = Alamofire.Parameters()
        parameters["postId"] = postId
        
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
    
    func getHomeDetail(pursuitId : Int?, completion: @escaping (HomeDetail) -> ()){
        let url = "http://localhost:8080/posts/get_post_details"
        let defaults = UserDefaults.standard
      
        var parameters = Alamofire.Parameters()
        parameters["userId"] = 1
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
    
    func getResponses(pursuitId : Int?, completion: @escaping (HomeDetail) -> ()){
        let url = "http://localhost:8080/posts/get_responses"
        
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
    
    func getKeyPosts(pursuitId : Int?, completion: @escaping (HomeDetail) -> ()){
        let url = "http://localhost:8080/posts/get_key_posts"
        
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
    
    func getHomeDetailDays(pursuitId : Int, completion: @escaping ([HomeDetail]) -> ()){
        let url = "http://localhost:8080/posts/get_days"
//        let defaults = UserDefaults.standard
        
        var parameters = Alamofire.Parameters()
//        parameters["userId"] = defaults.integer(forKey: "userId")
        parameters["pursuitId"] = pursuitId
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let homeResponse = try JSONDecoder().decode([HomeDetail].self, from: data)
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
    

}
