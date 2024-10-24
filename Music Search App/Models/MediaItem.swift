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
    let artistBio: String?
    let artistLinkUrl: String?
}
