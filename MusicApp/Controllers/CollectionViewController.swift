//
//  CollectionViewController.swift
//  MusicApp
//
//  Created by Артём Устинов on 15.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {

    var networkModel: AlbumModel?

        override func viewDidLoad() {
            super.viewDidLoad()
            
            fetchData()
            
        }
        
        private func fetchData() {
            NetworkManager.shared.fetchData { [unowned self] data in
                self.networkModel = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }


    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        networkModel?.resultCount ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
    
        guard let stringUrl = networkModel?.results?[indexPath.row].artworkUrl100 else { return cell }
        guard let url = URL(string: stringUrl) else { return cell }
        guard let dataImage = try? Data(contentsOf: url) else { return cell }
        
        cell.albumCellImage.image = UIImage(data: dataImage)
        
        cell.backgroundColor = .black
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 4
        let paddingWidth = 13 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
                
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
