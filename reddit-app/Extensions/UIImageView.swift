//
//  UIImageView.swift
//  reddit-app
//
//  Created by Jackie Ramos on 03/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    ///Load image with caching
    ///
    /// - Parameters:
    ///   - urlString: Image URL string
    func loadImagesUsingCacheWithUrlString(urlString: String, completion: (()->Void)? = nil) {

        self.image = nil
        self.contentMode = .scaleAspectFill
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {

            self.image = cachedImage
            return
        }

        let url = URL(string: urlString)
        
        guard let validURL = url else {
            return
        }

        URLSession.shared.dataTask(with: validURL, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async  {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                    
                    completion?()
                }
            }
        }).resume()
    }
}
