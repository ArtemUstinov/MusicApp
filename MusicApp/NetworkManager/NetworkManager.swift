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
    
    //MARK: - Enums
    enum ApiUrl {
        static let allAlbumTest =
        "https://itunes.apple.com/lookup?amgArtistId=4576&entity=album&limit=55"
        
        static let album =
        "https://itunes.apple.com/lookup?id=%@&entity=song&limit=200"
        
        static let searchName = "https://itunes.apple.com/search?term=%@&entity=album"
    }
    
    //MARK: - Fetch search data of albums
    func fetchDataAlbums(searchName: String,
                         completion: @escaping(Result<[Album], Error>) -> Void) {
        
        let urlString = String(format: ApiUrl.searchName, searchName)
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let allAlbums = try JSONDecoder().decode(ResultModel<Album>.self,
                                                         from: data)
                completion(.success(allAlbums.results ?? []))
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    //MARK: - Fetch data of tracks for album
    func fetchDataTracks(album: Int?,
                         completion: @escaping(Result<[Track], Error>) -> Void) {
        
        let urlString = String(format: ApiUrl.album, String(album ?? 0))
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let tracks = try JSONDecoder().decode(ResultModel<Track>.self,
                                                      from: data)
                completion(.success(tracks.results ?? []))
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    //MARK: - Fetch data of image for albums
    func fetchImageData(from url: URL, completion: @escaping(Data) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "")
                return
            }
            completion(data)
        }.resume()
    }
}
