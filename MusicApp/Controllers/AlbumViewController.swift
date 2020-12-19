//
//  AlbumViewController.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private properties:
    private var albums: [AlbumResultsModel]?
    private var sortedAlbumResults: [AlbumResultsModel] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataAlbum()
        getSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailsVC = segue.destination as! InfoAlbumViewController
        let albumCell = sender as! UICollectionViewCell
        guard let indexPath = collectionView.indexPath(for: albumCell) else { return }
        
        let result = getFilteredResult(indexPath: indexPath)
        
        DispatchQueue.main.async {
            detailsVC.fetchDataArtist(albumId: result?.collectionId)
        }
    }
    
    //MARK: - Private methods:
    private func fetchDataAlbum() {
        
        NetworkManager.shared.fetchDataAlbum { [unowned self] dataAlbums in
            
            let dataAlbums = dataAlbums.results?.filter { $0.wrapperType != "artist" }
            
            self.albums = dataAlbums
            self.albums = self.albums?.sorted { $0.collectionName ?? "" < $1.collectionName ?? "" }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollection view data source
extension AlbumViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        isFiltering ? sortedAlbumResults.count : albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell",
                                               for: indexPath) as! InfoAlbumCell
        
        let result = getFilteredResult(indexPath: indexPath)
        
        cell.configureAlbumCell(with: result, indexPath: indexPath)
        return cell
    }
}

//MARK: - UICollection view delegate flow layout
extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 4
        let paddingWidth = 13 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: 5, left: 16, bottom: 16, right: 16)
    }
}

//MARK: - UISearch controller
extension AlbumViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func getFilteredResult(indexPath: IndexPath) -> AlbumResultsModel? {
        let result = isFiltering
            ? sortedAlbumResults[indexPath.row]
            : albums?[indexPath.row]
        
        return result
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        sortedAlbumResults = albums?.filter { dataValue in
            let dataValue = dataValue.collectionName?.lowercased()
            return dataValue?.contains(searchText.lowercased()) ?? false
            } ?? []
        
        collectionView.reloadData()
    }
    
    private func getSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter the name of the album"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField =
            searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 15)
            textField.textColor = .black
        }
    }
}


