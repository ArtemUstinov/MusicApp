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
    
    func fetchData(completion: @escaping(AlbumModel) -> Void) {
        
        guard let url = URL(string: URLS.iTunesAlbum.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let resultData = try JSONDecoder().decode(AlbumModel.self, from: data)
                completion(resultData)
                print(resultData)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
