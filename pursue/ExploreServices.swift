//
//  ExploreServices.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class ExploreServices {
    
    // MARK: - GET pursuits by interests
    
    func getPursuits(completion: @escaping (Pursuit, Post, Steps, User, Principles) -> ()){
        let url = "http://localhost:8080/"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - GET users
    
    func getUsers(completion: @escaping (User) -> ()){
        let url = "http://localhost:8080/"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
    
    // MARK: - QUERY database by user input
    
    func queryDatabase(searchText : String, completion: @escaping (Search) -> ()){
        let url = "http://localhost:8080/search"
        var parameters = Alamofire.Parameters()
        parameters["searchText"] = searchText
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let searchResponse = try JSONDecoder().decode(Search.self, from: data)
                completion(searchResponse)
            } catch let error {
                print(error)
            }
        }
    }
}
