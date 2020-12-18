//
//  NetworkManager.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Public methods:
    func fetchDataAlbum(completion: @escaping(AlbumModel) -> Void) {
        
        guard let url = URL(string: URLS.album.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let resultDataAlbum = try JSONDecoder().decode(AlbumModel.self, from: data)
                completion(resultDataAlbum)
                //                print(resultDataAlbum)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchDataArtist(album: Int, completion: @escaping(TrackModel) -> Void) {
        
        let art =
        "https://itunes.apple.com/lookup?id=\(album)&entity=song&limit=200"
        
        //        guard let url = URL(string: URLS.artist.rawValue) else { return }
        guard let url = URL(string: art) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let resultDataArtist = try JSONDecoder().decode(TrackModel.self, from: data)
                completion(resultDataArtist)
                //                print(resultDataArtist)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
