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
    let artistId: Int?
    let artistName: String?
    let artworkUrl100: String?
    let trackViewUrl: String?
    let artistViewUrl: String?
    let wrapperType: String?
    let kind: String?
    let collectionName: String?
    let releaseDate: String?
    let trackTimeMillis: Int?
    let collectionPrice: Double?
}

struct LookupResponse: Codable {
    let resultCount: Int
    let results: [ArtistDetails]
}

struct ArtistDetails: Codable {
    let artistId: Int
    let artistName: String
    let primaryGenreName: String?
    let artistBio: String?  // This field may not be provided by the iTunes API, but you can mock it if needed.
    let artistLinkUrl: String?  // The link to the artist's page outside the app

    // Other possible fields you can include depending on what iTunes provides
    let collectionCount: Int?
    let trackCount: Int?
    let collectionName: String?
    let trackName: String?
    let wrapperType: String?
    let kind: String?
}

class MediaSearchService {
    
    // Метод для поиска медиа через iTunes API
//    func searchMedia(query: String, completion: @escaping (ResponseResult<SearchResult>?) -> Void) {
//        let urlString = "https://itunes.apple.com/search?term=\(query)&limit=30&media=music"
//        guard let url = URL(string: urlString) else { return }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Ошибка: \(error.localizedDescription)")
//                completion(nil) // Возвращаем ошибку
//                return
//            }
//            
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            
//            do {
//                let result = try JSONDecoder().decode(SearchResult.self, from: data)
//                completion(ResponseResult(status: .success, data: result))  // Без параметра message
//            } catch {
//                print("Ошибка парсинга: \(error.localizedDescription)")
//                completion(ResponseResult(status: .failed, message: "Ошибка парсинга данных"))
//            }
//        }
//        task.resume()
//    }
    
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
