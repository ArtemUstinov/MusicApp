//
//  AlbumViewController.swift
//  MusicApp
//
//  Created by Артём Устинов on 14.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//


//https://itunes.apple.com/search?term=2pac&media=music

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailsVC = segue.destination as! DetailsViewController
        let albumCell = sender as! UICollectionViewCell
        guard let indexPath = collectionView.indexPath(for: albumCell) else { return }
        
        detailsVC.fetchDataArtist(albumId: self.albums?[indexPath.item].collectionId)
    }
    
    //MARK: - Private methods:
    private func fetchDataAlbum() {
        
        NetworkManager.shared.fetchDataAlbum { [unowned self] dataAlbums in
            let dataAlbums = dataAlbums.results?.filter({ x -> Bool in
                x.wrapperType != "artist"
            })
            self.albums = dataAlbums
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        sortedAlbumResults = albums?.filter { dataValue in
            let dataValue = dataValue.collectionName?.lowercased()
            return dataValue?.contains(searchText.lowercased()) ?? false
            } ?? []
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func getSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter the name of the album"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 15)
            textField.textColor = .black
        }
    }
}

//MARK: UICollection view data source
extension AlbumViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        isFiltering ? sortedAlbumResults.count : albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell",
                                                      for: indexPath) as! AlbumCell
        
//        guard let stringUrl = albums?[indexPath.row].artworkUrl100 else {
//            return cell.self }
//        guard let url = URL(string: stringUrl) else { return cell }
//        guard let dataImage = try? Data(contentsOf: url) else { return cell }
//        
//        cell.albumCellImage.image = UIImage(data: dataImage)
        
        cell.configureAlbumCell(with: albums, indexPath: indexPath)
        
        return cell
    }
}


extension AlbumViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}

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
}
