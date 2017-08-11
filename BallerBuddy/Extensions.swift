//
//  Extensions.swift
//  BallerBuddy
//
//  Created by Raj Patel on 8/11/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithURLString(urlString: String){
        
        self.image = nil
        
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        
        // otherwise new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            // download hit error
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async() {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
        }).resume()
        
    }
    
}
