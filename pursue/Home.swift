//
//  Home.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Home : Decodable {
    
    let returned_content : [HomePostContent]?
    let steps : [SearchedSteps]?
    let principles : [SearchedPrinciples]?
    let searched_users : [SearchedUsers]?
}
