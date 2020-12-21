//
//  InfoAlbumCell.swift
//  MusicApp
//
//  Created by Артём Устинов on 15.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//
//
import UIKit

class InfoAlbumCell: UICollectionViewCell {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var albumCellImage: UIImageView!
    
    //MARK: - Public methods:
    func configureAlbumCell(with albums: [AlbumResultsModel]?,
                            indexPath: IndexPath) {
        
        albumCellImage.layer.cornerRadius = albumCellImage.frame.height / 10
        
        guard let stringUrl = albums?[indexPath.row].albumPicture else { return }
        guard let url = URL(string: stringUrl) else { return }
        guard let dataImage = try? Data(contentsOf: url) else { return }
        
        self.albumCellImage.image = UIImage(data: dataImage)
    }
}
