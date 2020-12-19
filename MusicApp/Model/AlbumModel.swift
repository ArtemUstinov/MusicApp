//
//  NetworkModel.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

enum URLS: String {
    case album =
    "https://itunes.apple.com/lookup?amgArtistId=4576&entity=album&limit=55"
}

//MARK: - Track model
struct TrackModel: Decodable {
    let resultCount: Int?
    let results: [TrackResultsModel]?
}

struct TrackResultsModel: Decodable {
    let wrapperType: String?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionId: Int?
    let albumPicture: String?
    let trackPrice: Double?
    let collectionPrice: Double?
    let currency: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistName
        case collectionName
        case trackName
        case collectionId
        case albumPicture = "artworkUrl100"
        case trackPrice
        case collectionPrice
        case currency
    }
}

//MARK: - Album model
struct AlbumModel: Decodable {
    let resultCount: Int?
    let results: [AlbumResultsModel]?
}

struct AlbumResultsModel: Decodable {
    let wrapperType: String?
    let collectionName: String?
    let collectionType: String?
    let collectionId: Int?
    let albumPicture: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case collectionName
        case collectionType
        case collectionId
        case albumPicture = "artworkUrl100"
    }
}



