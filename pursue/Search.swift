//
//  Search.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/19/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct Search : Decodable {
    
    let users : SearchedUsers?
    let principles : [SearchedPrinciples]
    let steps : [SearchedSteps]
}
