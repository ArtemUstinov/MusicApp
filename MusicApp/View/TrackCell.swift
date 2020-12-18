//
//  TrackCell.swift
//  MusicApp
//
//  Created by Артём Устинов on 18.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    func configureTrackCell(with infoOfAlbum: [TrackResultsModel]?,
                            indexPath: IndexPath) {
        
        trackNameLabel.text = infoOfAlbum?[indexPath.row].trackName
        
        albumImage.image = getImageData(with: infoOfAlbum,
                                        indexPath: indexPath)
    }
    
    private func getImageData(with infoOfAlbum: [TrackResultsModel]?,
                              indexPath: IndexPath) -> UIImage? {
        
        albumImage.layer.cornerRadius = albumImage.frame.height / 7
        
        guard let stringUrl = infoOfAlbum?[indexPath.row].albumPicture else {
            return nil }
        guard let url = URL(string: stringUrl) else { return nil }
        guard let dataImage = try? Data(contentsOf: url) else { return nil }
        
        return UIImage(data: dataImage)
    }
}
