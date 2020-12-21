//
//  AlbumsViewController.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private properties:
    private let alertController = AlertController()
    private var sortedAlbumResults: [Album] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var isFiltering: Bool {
        searchController.isActive
            && !(searchController.searchBar.text?.isEmpty ?? false)
    }
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailsVC = segue.destination as? InfoAlbumViewController,
            let albumCell = sender as? UICollectionViewCell,
            let indexPath = collectionView.indexPath(for: albumCell) else { return }
        let result = getFilteredResult(indexPath: indexPath)
        
        DispatchQueue.main.async {
            detailsVC.fetchDataArtist(albumId: result?.collectionId)
        }
    }
    
    //MARK: - Private methods:
    private func fetchDataAlbum(with text: String) {
        
        NetworkManager.shared.fetchDataAlbums(searchName: text) {
            [weak self] resultData in
            
            switch resultData {
            case .success(let dataAlbums):
                var dataAlbums = dataAlbums.filter { $0.wrapperType != "artist" }
                dataAlbums = dataAlbums.sorted {
                    $0.collectionName ?? "" < $1.collectionName ?? ""
                }
                self?.sortedAlbumResults = dataAlbums
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                self?.alertController.show(error) { alert in
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

//MARK: - UICollection view data source
extension AlbumsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        isFiltering ? sortedAlbumResults.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell",
                                               for: indexPath) as? InfoAlbumCell else {
                                                fatalError("Error! Not cell")
                                                
        }
        
        let result = getFilteredResult(indexPath: indexPath)
        
        cell.configure(with: result, indexPath: indexPath)
        return cell
    }
}

//MARK: - UICollection view delegate flow layout
extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    
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
extension AlbumsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func getFilteredResult(indexPath: IndexPath) -> Album? {
        
        isFiltering ? sortedAlbumResults[indexPath.row] : nil
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        fetchDataAlbum(with: searchText)
        
        sortedAlbumResults = sortedAlbumResults.filter { dataValue in
            let dataValue = dataValue.collectionName?.lowercased()
            return dataValue?.contains(searchText.lowercased()) ?? false
        }
        
        collectionView.reloadData()
    }
    
    private func getSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder =
        "Enter the name of the album or singer"
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


