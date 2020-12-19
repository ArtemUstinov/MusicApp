//
//  InfoAlbumViewController.swift
//  MusicApp
//
//  Created by Артём Устинов on 15.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class InfoAlbumViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var priceAlbumLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var tracksLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Public properties:
    private var infoOfAlbum: [TrackResultsModel]?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        activityIndicator.startActivityIndicator(delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoTrackVC = segue.destination as! InfoTrackViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        infoTrackVC.infoTrack = infoOfAlbum?[indexPath.row]
    }
    
    //MARK: - Public methods:
    func fetchDataArtist(albumId: Int?) {
        
        NetworkManager.shared.fetchDataArtist(album: albumId ?? 0) {
            [unowned self] dataOfAlbum in
            let dataOfAlbum = dataOfAlbum.results?.filter({ x -> Bool in
                x.wrapperType != "collection"
            })
            self.infoOfAlbum = dataOfAlbum
            
            DispatchQueue.main.async {
                self.setupUI()
                self.activityIndicator.finishActivityIndicator(delegate: self)
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Private methods:
    private func setupUI() {
        
        tracksLabel.text = "The album has \(infoOfAlbum?.count ?? 0) tracks:"
        
        for info in infoOfAlbum ?? [] {
            albumNameLabel.text = info.collectionName
            priceAlbumLabel.text = "\(info.collectionPrice ?? 0) \(info.currency ?? "")"
            
            guard let url = URL(string: info.albumPicture ?? "") else { return }
            guard let dataImage = try? Data(contentsOf: url) else { return }
            albumImage.image = UIImage(data: dataImage)
            albumImage.layer.cornerRadius = albumImage.frame.width / 50
        }
    }
    
    deinit {
        print("Deinit", InfoAlbumViewController.self)
    }
}

//MARK: - UITable view data source
extension InfoAlbumViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        infoOfAlbum?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell",
                                                 for: indexPath) as! TrackCell
        
        cell.configureTrackCell(with: infoOfAlbum, indexPath: indexPath)
        
        return cell
    }
}

extension InfoAlbumViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
