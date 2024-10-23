//
//  MusicSearchViewModel.swift
//  Music Search App
//
//  Created by Bakhtovar on 22/10/24.
//

import Foundation

//class MusicSearchViewModel {
//
//    // Сервис для выполнения запросов (можно заменить своим сетевым сервисом)
//    private let service = MediaSearchService()
//
//    // ---------------------------------------------------
//    // MARK: - Properties
//    // ---------------------------------------------------
//
//    /// Результаты поиска медиа
//    var mediaResults: [MediaItem]? = nil {
//        didSet {
//            self.didSetMediaResults?(mediaResults)
//        }
//    }
//
//    /// Статус выполнения поиска (загрузка)
//    private(set) var searchInProcess: Bool = false {
//        didSet {
//            self.didSetSearchInProcess?(searchInProcess)
//        }
//    }
//
//    /// Ошибка при выполнении поиска
//    private(set) var searchError: ErrorResult? = nil {
//        didSet {
//            self.didSetSearchError?(searchError)
//        }
//    }
//
//    // Замыкания для обновления UI
//    var didSetMediaResults: (([MediaItem]?) -> Void)? = nil
//    var didSetSearchInProcess: ((Bool) -> Void)? = nil
//    var didSetSearchError: ((ErrorResult?) -> Void)? = nil
//
//    // ---------------------------------------------------
//    // MARK: - Public Methods
//    // ---------------------------------------------------
//
//    /// Выполняет поиск медиа по заданному запросу
//    public func searchMedia(query: String) {
//        self.searchInProcess = true
//
//        // Выполняем поиск через сервис
//        service.searchMedia(query: query) { [weak self] responseResult in
//            // Сбросим статус "в процессе" после завершения запроса
//            self?.searchInProcess = false
//
//            if let responseResult = responseResult {
//                if responseResult.status == .success {
//                    // Если запрос успешен, сохраняем результаты
//                    self?.mediaResults = responseResult.data?.results
//                } else if responseResult.status == .failed {
//                    // Обработка ошибок сервера
//                    self?.searchError = ErrorResult(
//                        title: "Ошибка",
//                        message: responseResult.message ?? "Неизвестная ошибка",
//                        type: "server"
//                    )
//                } else if responseResult.status == .timeOut {
//                    // Обработка ошибок таймаута
//                    self?.searchError = ErrorResult(
//                        title: "Таймаут",
//                        message: "Превышено время ожидания",
//                        type: "timeout"
//                    )
//                } else {
//                    // Прочие ошибки подключения
//                    self?.searchError = ErrorResult(
//                        title: "Ошибка соединения",
//                        message: "Проблемы с подключением к сети",
//                        type: "connection"
//                    )
//                }
//            }
//        }
//    }
//}

//class MusicSearchViewModel {
//
//    // Service for fetching media data (replace with actual API service)
//    private let service = MediaSearchService()
//
//    // Key for storing search history in UserDefaults
//    private let searchHistoryKey = "searchHistory"
//
//    // Maximum number of search history items to store
//    private let maxHistoryCount = 5
//
//    // ---------------------------------------------------
//    // MARK: - Properties
//    // ---------------------------------------------------
//
//    /// Media search results
//    var mediaResults: [MediaItem]? = nil {
//        didSet {
//            self.didSetMediaResults?(mediaResults)
//        }
//    }
//
//    /// Indicates if search is currently in progress
//    private(set) var searchInProcess: Bool = false {
//        didSet {
//            self.didSetSearchInProcess?(searchInProcess)
//        }
//    }
//
//    /// Search error result
//    private(set) var searchError: ErrorResult? = nil {
//        didSet {
//            self.didSetSearchError?(searchError)
//        }
//    }
//
//    // Closures for updating UI
//    var didSetMediaResults: (([MediaItem]?) -> Void)? = nil
//    var didSetSearchInProcess: ((Bool) -> Void)? = nil
//    var didSetSearchError: ((ErrorResult?) -> Void)? = nil
//
//    // ---------------------------------------------------
//    // MARK: - Public Methods
//    // ---------------------------------------------------
//
//    /// Performs media search for the provided query
//    public func searchMedia(query: String) {
//        self.searchInProcess = true
//
//        // Save search query to history
//        saveSearchQuery(query)
//
//        // Call the service to search media
//        service.searchMedia(query: query) { [weak self] responseResult in
//            // Set searchInProcess to false after request completion
//            self?.searchInProcess = false
//
//            if let responseResult = responseResult {
//                if responseResult.status == .success {
//                    // If search is successful, save media results
//                    self?.mediaResults = responseResult.data?.results
//                } else if responseResult.status == .failed {
//                    // Handle server errors
//                    self?.searchError = ErrorResult(
//                        title: "Error",
//                        message: responseResult.message ?? "Unknown error",
//                        type: "server"
//                    )
//                } else if responseResult.status == .timeOut {
//                    // Handle timeout errors
//                    self?.searchError = ErrorResult(
//                        title: "Timeout",
//                        message: "Request timed out",
//                        type: "timeout"
//                    )
//                } else {
//                    // Handle other connection errors
//                    self?.searchError = ErrorResult(
//                        title: "Connection Error",
//                        message: "Network connection issues",
//                        type: "connection"
//                    )
//                }
//            }
//        }
//    }
//
//    /// Saves a new search query to history (up to maxHistoryCount)
//    private func saveSearchQuery(_ query: String) {
//        var history = getSearchHistory()
//
//        // Remove the query if it already exists (to avoid duplicates)
//        if let index = history.firstIndex(of: query) {
//            history.remove(at: index)
//        }
//
//        // Add the new query at the top of the list
//        history.insert(query, at: 0)
//
//        // Keep only the latest `maxHistoryCount` queries
//        if history.count > maxHistoryCount {
//            history = Array(history.prefix(maxHistoryCount))
//        }
//
//        // Save updated history to UserDefaults
//        UserDefaults.standard.set(history, forKey: searchHistoryKey)
//    }
//
//    /// Retrieves the search history from UserDefaults
//    public func getSearchHistory() -> [String] {
//        return UserDefaults.standard.stringArray(forKey: searchHistoryKey) ?? []
//    }
//
//    /// Clears the search history (optional feature)
//    public func clearSearchHistory() {
//        UserDefaults.standard.removeObject(forKey: searchHistoryKey)
//    }
//}

import Foundation

class MusicSearchViewModel {
    
    // Service for fetching media data (replace with actual API service)
    private let service = MediaSearchService()
    
    // Key for storing search history in UserDefaults
    private let searchHistoryKey = "searchHistory"
    
    // Maximum number of search history items to store
    private let maxHistoryCount = 5
    
    // ---------------------------------------------------
    // MARK: - Properties
    // ---------------------------------------------------
    
    /// Media search results
    var mediaResults: [MediaItem]? = nil {
        didSet {
            self.didSetMediaResults?(mediaResults)
        }
    }
    
    /// Indicates if search is currently in progress
    private(set) var searchInProcess: Bool = false {
        didSet {
            self.didSetSearchInProcess?(searchInProcess)
        }
    }
    
    /// Search error result
    private(set) var searchError: ErrorResult? = nil {
        didSet {
            self.didSetSearchError?(searchError)
        }
    }
    
    /// Filtered suggestions based on the search text
    var filteredSuggestions: [String] = [] {
        didSet {
            self.didUpdateSuggestions?(filteredSuggestions)
        }
    }
    
    // Properties for handling artist lookup
    var artistDetails: ArtistDetails? {
        didSet {
            self.didSetArtistDetails?(artistDetails)
        }
    }
    
    private(set) var artistLookupInProgress: Bool = false {
        didSet {
            self.didSetArtistLookupInProgress?(artistLookupInProgress)
        }
    }
    
    private(set) var artistLookupError: ErrorResult? = nil {
        didSet {
            self.didSetArtistLookupError?(artistLookupError)
        }
    }
    
    
    // Closures for updating UI
    var didSetMediaResults: (([MediaItem]?) -> Void)? = nil
    var didSetSearchInProcess: ((Bool) -> Void)? = nil
    var didSetSearchError: ((ErrorResult?) -> Void)? = nil
    var didUpdateSuggestions: (([String]) -> Void)? = nil
    
    var didSetArtistDetails: ((ArtistDetails?) -> Void)?
    var didSetArtistLookupInProgress: ((Bool) -> Void)?
    var didSetArtistLookupError: ((ErrorResult?) -> Void)?
    
    
    // ---------------------------------------------------
    // MARK: - Public Methods
    // ---------------------------------------------------
    
    /// Performs media search for the provided query
    public func searchMedia(query: String, limit: Int = 30) {
        self.searchInProcess = true
        // Save search query to history
        saveSearchQuery(query)
        // Call the service to search media with the dynamic limit
        service.searchMedia(query: query, limit: limit) { [weak self] responseResult in
            // Set searchInProcess to false after request completion
            self?.searchInProcess = false
            
            if let responseResult = responseResult {
                if responseResult.status == .success {
                    // If search is successful, save media results
                    self?.mediaResults = responseResult.data?.results
                } else if responseResult.status == .failed {
                    // Handle server errors
                    self?.searchError = ErrorResult(
                        title: "Error",
                        message: responseResult.message ?? "Unknown error",
                        type: "server"
                    )
                } else if responseResult.status == .timeOut {
                    // Handle timeout errors
                    self?.searchError = ErrorResult(
                        title: "Timeout",
                        message: "Request timed out",
                        type: "timeout"
                    )
                } else {
                    // Handle other connection errors
                    self?.searchError = ErrorResult(
                        title: "Connection Error",
                        message: "Network connection issues",
                        type: "connection"
                    )
                }
            }
        }
    }
    
    // Method for looking up artist details
    public func lookupArtist(artistId: Int) {
        self.artistLookupInProgress = true
        
        service.lookupArtist(artistId: artistId) { [weak self] responseResult in
            self?.artistLookupInProgress = false
            
            if let responseResult = responseResult {
                if responseResult.status == .success {
                    self?.artistDetails = responseResult.data?.results.first
                } else if responseResult.status == .failed {
                    // Handle server errors
                    self?.searchError = ErrorResult(
                        title: "Error",
                        message: responseResult.message ?? "Unknown error",
                        type: "server"
                    )
                } else if responseResult.status == .timeOut {
                    // Handle timeout errors
                    self?.searchError = ErrorResult(
                        title: "Timeout",
                        message: "Request timed out",
                        type: "timeout"
                    )
                } else {
                    // Handle other connection errors
                    self?.searchError = ErrorResult(
                        title: "Connection Error",
                        message: "Network connection issues",
                        type: "connection"
                    )
                }
                
            }
        }
    }
    
    /// Filters search history suggestions based on the input query
    public func filterSuggestions(for query: String) {
        let history = getSearchHistory()
        filteredSuggestions = history.filter { $0.range(of: query, options: .caseInsensitive) != nil }
    }
    
    /// Saves a new search query to history (up to maxHistoryCount)
    func saveSearchQuery(_ query: String) {
        var history = getSearchHistory()
        
        // Remove the query if it already exists (to avoid duplicates)
        if let index = history.firstIndex(of: query) {
            history.remove(at: index)
        }
        
        // Add the new query at the top of the list
        history.insert(query, at: 0)
        
        // Keep only the latest `maxHistoryCount` queries
        if history.count > maxHistoryCount {
            history = Array(history.prefix(maxHistoryCount))
        }
        
        // Save updated history to UserDefaults
        UserDefaults.standard.set(history, forKey: searchHistoryKey)
    }
    
    /// Retrieves the search history from UserDefaults
    public func getSearchHistory() -> [String] {
        return UserDefaults.standard.stringArray(forKey: searchHistoryKey) ?? []
    }
    
    /// Clears the search history (optional feature)
    public func clearSearchHistory() {
        UserDefaults.standard.removeObject(forKey: searchHistoryKey)
    }
}
