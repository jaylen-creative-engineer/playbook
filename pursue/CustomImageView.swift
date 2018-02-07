//
//  CustomImageView.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

var imageCache = [String : UIImage]()
let cacheObjectImageLoader = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var lastURLUsedToLoadImage : String?
    
    // MARK: - Loading Image From Cache or URL
    
    func loadImage(urlString: String) {
        
        lastURLUsedToLoadImage = urlString
        self.image = nil
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch post", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage { return }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
            }.resume()
    }
}

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = cacheObjectImageLoader.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        guard let url = URL(string : urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    cacheObjectImageLoader.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}
