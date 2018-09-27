//
//  Story.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/24/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import Foundation
import AVFoundation

class Story: Equatable{
    var caption : String?
    var profileName : String?
    var description : String?
    var time : String?
    var videoName : String?
    var avPlayerItem: AVPlayerItem?
    var videoDuration: Double?
    
    init(caption: String, profileName: String, description: String, time: String, videoName: String) {
        self.caption = caption
        self.profileName = profileName
        self.description = description
        self.time = time
        self.videoName = videoName
        let videoString:String? = Bundle.main.path(forResource: videoName, ofType: "mp4")
        guard let unwrappedVideoPath = videoString else {return}
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        self.avPlayerItem = AVPlayerItem(url: videoUrl)
        self.videoDuration = self.avPlayerItem?.asset.duration.seconds
    }
    
    static func == (lhs: Story, rhs: Story) -> Bool {
        if(lhs.caption == rhs.caption && lhs.profileName == rhs.profileName && lhs.description == rhs.description && lhs.time == rhs.time && lhs.videoName == rhs.videoName){
            return true
        }
        return false
    }
    
}
