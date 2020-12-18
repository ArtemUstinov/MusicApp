//
//  AlbumCell.swift
//  MusicApp
//
//  Created by Артём Устинов on 15.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//
//
import UIKit

class AlbumCell: UICollectionViewCell {

    @IBOutlet weak var albumCellImage: UIImageView!
    
    func configureAlbumCell(with albums: [AlbumResultsModel]?, indexPath: IndexPath) {
                
        guard let stringUrl = albums?[indexPath.row].albumPicture else { return }
        guard let url = URL(string: stringUrl) else { return }
        guard let dataImage = try? Data(contentsOf: url) else { return }
        
        self.albumCellImage.image = UIImage(data: dataImage)
    }
}
