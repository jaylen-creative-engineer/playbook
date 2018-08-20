//
//  Post.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

struct Post : Decodable {
    let postId : String?
    let postThumbnail : String?
    let contentUrl : URL?
    let postType : String?
    let postImage : Data?
}
