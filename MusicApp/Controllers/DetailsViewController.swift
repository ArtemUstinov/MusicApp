//
//  DetailsViewController.swift
//  MusicApp
//
//  Created by Артём Устинов on 15.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var tracksLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Public properties:
    private var infoOfAlbum: [TrackResultsModel]?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Private methods:
    private func setupUI() {
        
        tracksLabel.text = "The album has \(infoOfAlbum?.count ?? 0) tracks:"
        
        for info in infoOfAlbum ?? [] {
            albumNameLabel.text = info.collectionName
            
            guard let url = URL(string: info.albumPicture ?? "") else { return }
            guard let dataImage = try? Data(contentsOf: url) else { return }
            albumImage.image = UIImage(data: dataImage)
            albumImage.layer.cornerRadius = albumImage.frame.width / 50
        }
    }
    
    deinit {
        print("DEINIT!")
    }
}

//MARK: - UITable view data source
extension DetailsViewController: UITableViewDataSource {
    
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

extension DetailsViewController: UITableViewDelegate {
}
