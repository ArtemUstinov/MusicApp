//
//  ViewController.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//


//https://itunes.apple.com/search?term=2pac&media=music

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private properties:
    private var networkModel: AlbumModel?
    
    private let searchController = UISearchController(searchResultsController: nil)

    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        getSearchController()
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData { [unowned self] data in
            self.networkModel = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func getSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter the name of album"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
//        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
//            textField.font = UIFont.boldSystemFont(ofSize: 17)
//            textField.textColor = .white
//        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        networkModel?.resultCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
                        
        guard let stringUrl = networkModel?.results?[indexPath.row].artworkUrl100 else { return cell }
        guard let url = URL(string: stringUrl) else { return cell }
        guard let dataImage = try? Data(contentsOf: url) else { return cell }

        cell.albumCellImage.image = UIImage(data: dataImage)
        
        cell.backgroundColor = .black
        
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
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

