//
//  NetworkModel.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

    //MARK: - Generic model for Album and Track
struct ResultModel<T: Decodable>: Decodable {
    let resultCount: Int?
    let results: [T]?
}

    //MARK: - Album model
struct Album: Decodable {
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



