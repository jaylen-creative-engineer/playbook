//
//  AVPlayer+isPlaying.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/26/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import AVFoundation

extension AVPlayer {
    
    var isPlaying: Bool {
        return self.rate != 0 && self.error == nil
    }
}
