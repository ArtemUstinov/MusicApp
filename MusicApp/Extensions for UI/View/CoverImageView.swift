//
//  CoverImageView.swift
//  MusicApp
//
//  Created by Артём Устинов on 20.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class CoverImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else {
            image = #imageLiteral(resourceName: "album-art-empty")
            return
        }
        
        NetworkManager.shared.fetchImageData(from: url) { imageData in
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
