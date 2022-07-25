//
//  ImageLoader.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 23/07/2022.
//

import UIKit

class ImageLoaderView: UIImageView {
    
    private var urlTask: URLSessionDataTask?
    
    override var image: UIImage? {
        get {
            super.image
        }
        set {
            super.image = newValue
            
            if newValue == nil {
                urlTask?.cancel()
                urlTask = nil
            }
        }
    }
    
    func imageFrom(imageUrl: String, placeholder: UIImage? = nil) {
        if placeholder != nil {
            self.image = placeholder
        }
        
        guard let url = URL(string: imageUrl) else {
            return
        }

//        // Load from the cache
//        urlRequest.cachePolicy = .returnCacheDataDontLoad
        
        urlTask = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    super.image = UIImage(data: data)
                }
            }
        }
        
        urlTask?.resume()
    }
}
