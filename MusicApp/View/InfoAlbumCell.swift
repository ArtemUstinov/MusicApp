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
    @IBOutlet weak var albumCellImage: CoverImageView!
    
    //MARK: - Public methods:
    func configure(with albums: Album?,
                            indexPath: IndexPath) {
    
        albumCellImage.layer.cornerRadius = albumCellImage.frame.height / 10
        
        albumCellImage.fetchImage(from: albums?.albumPicture ?? "")
    }
}
