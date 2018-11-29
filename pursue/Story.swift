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
    var userPhoto : String?
    var thumbnailUrl : String?
    var time : String?
    var videoName : String?
    var avPlayerItem: AVPlayerItem?
    var videoDuration: Double?
    
    init(caption: String?, profileName: String?, userPhoto : String?, time: String?, videoName: String?, thumbnailUrl : String?) {
        self.caption = caption
        self.profileName = profileName
        self.time = time
        self.userPhoto = userPhoto
        self.videoName = videoName
        self.thumbnailUrl = thumbnailUrl
        
        guard let videoData = videoName else { return }
        guard let videoUrl = URL(string: videoData) else { return }
        self.avPlayerItem = AVPlayerItem(url: videoUrl)
        self.videoDuration = self.avPlayerItem?.asset.duration.seconds
    }
    
    static func == (lhs: Story, rhs: Story) -> Bool {
        if(lhs.caption == rhs.caption && lhs.userPhoto == rhs.userPhoto && lhs.thumbnailUrl == rhs.thumbnailUrl && lhs.profileName == rhs.profileName && lhs.time == rhs.time && lhs.videoName == rhs.videoName){
            return true
        }
        return false
    }
    
}
