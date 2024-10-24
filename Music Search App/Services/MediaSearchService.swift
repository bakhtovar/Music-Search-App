//
//  MediaSearchService.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import Foundation
import UIKit

class MediaSearchService {
    
    func searchMedia(query: String, limit: Int = 30, mediaType: String = "all", completion: @escaping (ResponseResult<SearchResult>?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(query)&limit=\(limit)&media=\(mediaType)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil) // Return the error
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(ResponseResult(status: .success, data: result))  // Without the message parameter
            } catch {
                print("Ошибка парсинга: \(error.localizedDescription)")
                completion(ResponseResult(status: .failed, message: "Ошибка парсинга данных"))
            }
        }
        task.resume()
    }
    
    // New method for performing artist lookup
    func lookupArtist(artistId: Int, completion: @escaping (ResponseResult<LookupResponse>?) -> Void) {
        let urlString = "https://itunes.apple.com/lookup?id=\(artistId)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(LookupResponse.self, from: data)
                completion(ResponseResult(status: .success, data: result))
            } catch {
                print("Parsing error: \(error.localizedDescription)")
                completion(ResponseResult(status: .failed, message: "Failed to parse artist details"))
            }
        }
        task.resume()
    }
}

struct ResponseResult<T> {
    let status: ResponseStatus
    let data: T?
    let message: String?
    
    init(status: ResponseStatus, data: T? = nil, message: String? = nil) {
        self.status = status
        self.data = data
        self.message = message
    }
}

enum ResponseStatus {
    case success
    case failed
    case timeOut
}

struct ErrorResult: Error {
    let title: String
    let message: String
    let type: String
}
