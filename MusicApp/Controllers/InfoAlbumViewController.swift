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
    
    @IBOutlet weak var albumImage: CoverImageView!
    @IBOutlet weak var priceAlbumLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var tracksLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Public properties:
    private var tracks: [Track]?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        startActivityIndicator()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoTrackVC = segue.destination as! InfoTrackViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        infoTrackVC.infoTrack = tracks?[indexPath.row]
    }
    
    //MARK: - Public methods:
    func fetchDataArtist(albumId: Int?) {
        
        NetworkManager.shared.fetchDataTracks(album: albumId) {
            [weak self] resultData in
            
            switch resultData {
            case .success(let dataTracks):
                let dataTracks = dataTracks.filter { $0.wrapperType != "collection" }
                self?.tracks = dataTracks
                
                DispatchQueue.main.async {
                    self?.setupUI()
                    self?.finishActivityIndicator()
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                //Alert
                print(error.localizedDescription)
            }     
        }
    }
    
    //MARK: - Private methods:
    private func setupUI() {
        
        tracksLabel.text = "The album has \(tracks?.count ?? 0) tracks:"
        
        for info in tracks ?? [] {
            albumNameLabel.text = info.collectionName
            priceAlbumLabel.text =
            "\(info.collectionPrice ?? 0) \(info.currency ?? "")"
            
            albumImage.fetchImage(from: info.albumPicture ?? "")
            albumImage.layer.cornerRadius = albumImage.frame.width / 50
        }
    }
    
    private func startActivityIndicator() {
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        albumImage.isHidden = true
        albumNameLabel.isHidden = true
        tracksLabel.isHidden = true
        priceAlbumLabel.isHidden = true
        tableView.isHidden = true
    }
    
    private func finishActivityIndicator() {
        
        activityIndicator.stopAnimating()
        
        albumImage.isHidden = false
        albumNameLabel.isHidden = false
        tracksLabel.isHidden = false
        priceAlbumLabel.isHidden = false
        tableView.isHidden = false
    }
    
    deinit {
        print("Deinit", InfoAlbumViewController.self)
    }
}

//MARK: - UITable view data source
extension InfoAlbumViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        tracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell",
                                                 for: indexPath) as! TrackCell
        
        cell.configure(with: tracks, indexPath: indexPath)
        
        return cell
    }
}

extension InfoAlbumViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
