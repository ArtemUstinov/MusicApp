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
    @IBOutlet weak var albumImage: CoverImageView!
    
    //MARK: - Public methods:
    func configure(with album: Album?, indexPath: IndexPath) {
        
        albumImage.layer.cornerRadius = albumImage.frame.height / 10
        
        albumImage.fetchImage(from: album?.albumPicture ?? "")
    }
}
