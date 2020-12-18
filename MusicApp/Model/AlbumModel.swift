//
//  NetworkModel.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

enum Ara {
    case nameAlbum (name: Int)
}


enum URLS: String {

    case artist = "https://itunes.apple.com/lookup?id=4576&entity=song&limit=200&sort=recent"

    case album = "https://itunes.apple.com/lookup?amgArtistId=4576&entity=album&limit=40"
}

struct TrackModel: Decodable {
    let resultCount: Int?
    let results: [TrackResultsModel]?
}

struct TrackResultsModel: Decodable {
    let wrapperType: String?
    let artistName: String?
    let collectionId: Int?
    let collectionName: String?
    let trackName: String?
    let albumPicture: String?
    let releaseDate: String?
    let trackCount: Int?
    let trackNumber: Int?
    let primaryGenreName: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistName
        case collectionName
        case trackName
        case collectionId
        case albumPicture = "artworkUrl100"
        case releaseDate
        case trackCount
        case trackNumber
        case primaryGenreName
    }
}


struct AlbumModel: Decodable {
    let resultCount: Int?
    let results: [AlbumResultsModel]?
}

struct AlbumResultsModel: Decodable {
    let wrapperType: String?
    let collectionType: String?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionId: Int?
    let albumPicture: String?
    let releaseDate: String?
    let trackCount: Int?
    let trackNumber: Int?
    let primaryGenreName: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case collectionType
        case artistName
        case collectionName
        case trackName
        case collectionId
        case albumPicture = "artworkUrl100"
        case releaseDate
        case trackCount
        case trackNumber
        case primaryGenreName
    }
}



