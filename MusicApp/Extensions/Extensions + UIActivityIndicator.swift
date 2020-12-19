//
//  Extensions + UIActivityIndicator.swift
//  MusicApp
//
//  Created by Артём Устинов on 19.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    
    //MARK: - Public methods:
    func startActivityIndicator(delegate infoAlbumVC: InfoAlbumViewController) {
        self.startAnimating()
        
        if self.isAnimating {
            infoAlbumVC.albumImage.isHidden = true
            infoAlbumVC.albumNameLabel.isHidden = true
            infoAlbumVC.tracksLabel.isHidden = true
            infoAlbumVC.priceAlbumLabel.isHidden = true
            infoAlbumVC.tableView.isHidden = true
        }
        self.hidesWhenStopped = true
    }
    
    func finishActivityIndicator(delegate infoAlbumVC: InfoAlbumViewController) {
        self.stopAnimating()
        
        infoAlbumVC.albumImage.isHidden = false
        infoAlbumVC.albumNameLabel.isHidden = false
        infoAlbumVC.tracksLabel.isHidden = false
        infoAlbumVC.priceAlbumLabel.isHidden = false
        infoAlbumVC.tableView.isHidden = false
    }
}
