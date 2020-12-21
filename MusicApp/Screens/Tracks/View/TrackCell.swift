//
//  TrackCell.swift
//  MusicApp
//
//  Created by Артём Устинов on 18.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var albumImage: CoverImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    
    //MARK: - Public methods:
    func configure(with infoOfAlbum: [Track]?, indexPath: IndexPath) {
        
        guard let trackPrice = infoOfAlbum?[indexPath.row].trackPrice,
            let currency = infoOfAlbum?[indexPath.row].currency else { return }
        trackNameLabel.text = infoOfAlbum?[indexPath.row].trackName
        trackPriceLabel.text = "\(trackPrice) \(currency)"
        
        albumImage.fetchImage(from: infoOfAlbum?[indexPath.row].albumPicture ?? "")
    }
}

