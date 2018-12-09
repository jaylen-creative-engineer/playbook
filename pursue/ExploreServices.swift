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
    var apiUrl = "https://arcane-mesa-59373.herokuapp.com"
    
    // MARK: - QUERY database by user input
    
    func queryDatabase(searchText : String, completion: @escaping (Search) -> ()){
        let url = apiUrl + "/search/get-search"
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
