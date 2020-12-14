//
//  NetworkModel.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import Foundation

enum URLS: String {
    case iTunes = "https://itunes.apple.com/search?term=2pac&media=music"
    case iTunesAlbum = "https://itunes.apple.com/search?term=2pac&media=music&entity=album"
}

//struct NetworkModel: Decodable {
//    let resultCount: Int?
//    let results: [Results]?
//}
//
//struct Results: Decodable {
//    let artistName: String?
//    let collectionName: String?
//    let trackName: String?
//    let artworkUrl100: String?
//    let releaseDate: String?
//    let trackCount: Int?
//    let trackNumber: Int?
//    let primaryGenreName: String?
//}


struct AlbumModel: Decodable {
    let resultCount: Int?
    let results: [Results]?
}

struct Results: Decodable {
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let trackCount: Int?
    let trackNumber: Int?
    let primaryGenreName: String?
}
