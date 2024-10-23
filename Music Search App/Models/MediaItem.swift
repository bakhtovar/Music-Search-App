//
//  Songs.swift
//  Music Search App
//
//  Created by Bakhtovar on 22/10/24.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [MediaItem]
}

struct MediaItem: Codable {
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let trackViewUrl: String?
    let wrapperType: String?
    let kind: String?
    let collectionName: String?
    let releaseDate: String?
    let trackTimeMillis: Int?
    let collectionPrice: Double?
}

class MediaSearchService {
    
    // Метод для поиска медиа через iTunes API
    func searchMedia(query: String, completion: @escaping (ResponseResult<SearchResult>?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(query)&limit=30&media=music"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
                completion(nil) // Возвращаем ошибку
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(ResponseResult(status: .success, data: result))  // Без параметра message
            } catch {
                print("Ошибка парсинга: \(error.localizedDescription)")
                completion(ResponseResult(status: .failed, message: "Ошибка парсинга данных"))
            }
        }
        task.resume()
    }
}

struct ResponseResult<T> {
    let status: ResponseStatus
    let data: T?
    let message: String?
    
    // Добавляем значение по умолчанию для message
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
