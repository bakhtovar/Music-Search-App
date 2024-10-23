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
    
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        task.resume()
    }
}
