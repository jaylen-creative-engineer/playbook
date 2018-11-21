//
//  Feed.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/17/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import Foundation

struct Feed {
        
    let post: Post
    let post_count : Int
    
    init(post: Post, post_count : Int) {
        self.post = post
        self.post_count = post_count
    }
}
