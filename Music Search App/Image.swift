//
//  Image.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
    
    private init() {}
    
//    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//            completion(UIImage(data: data))
//        }
//        task.resume()
//    }
    
    let cache = NSCache<NSString, UIImage>()

    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }
}
