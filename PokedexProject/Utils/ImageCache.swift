//
//  ImageCache.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 04/08/25.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private let placeholderImage = UIImage(systemName: "photo")
    
    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 10 * 1024 * 1024
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        
        completion(placeholderImage)
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data,
                      let image = UIImage(data: data),
                        error == nil
                else {
                    DispatchQueue.main.async {
                        completion(self.placeholderImage)
                    }
                    return
                }
                
                self.cache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            .resume()
        }
        
    }
}
