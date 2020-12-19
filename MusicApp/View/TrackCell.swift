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
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    
    //MARK: - Public methods:
    func configureTrackCell(with infoOfAlbum: [TrackResultsModel]?,
                            indexPath: IndexPath) {
        
        trackNameLabel.text = infoOfAlbum?[indexPath.row].trackName
        
        guard let trackPrice = infoOfAlbum?[indexPath.row].trackPrice else { return }
        guard let currency = infoOfAlbum?[indexPath.row].currency else { return }
        trackPriceLabel.text = "\(trackPrice) \(currency)"
        
        albumImage.image = getImageAlbum(with: infoOfAlbum,
                                        indexPath: indexPath)
    }
    
    //MARK: - Private methods:
    private func getImageAlbum(with infoOfAlbum: [TrackResultsModel]?,
                              indexPath: IndexPath) -> UIImage? {
        
        albumImage.layer.cornerRadius = albumImage.frame.width / 7
        
        guard let stringUrl = infoOfAlbum?[indexPath.row].albumPicture else {
            return nil }
        guard let url = URL(string: stringUrl) else { return nil }
        guard let dataImage = try? Data(contentsOf: url) else { return nil }
        
        return UIImage(data: dataImage)
    }
}
