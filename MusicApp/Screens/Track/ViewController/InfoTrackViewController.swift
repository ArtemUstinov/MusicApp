//
//  InfoTrackViewController.swift
//  MusicApp
//
//  Created by Артём Устинов on 18.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class InfoTrackViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var trackImage: CoverImageView!
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var currencyPriceTrackLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    //MARK: - Public properties:
    var infoTrack: Track?
    
    //MARK: - Private properties:
    private var isEditingMode = false
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - IBActions:
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        isEditingMode.toggle()
        if isEditingMode == true {
            sender.setImage(UIImage(systemName: "pause"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }
    
    //MARK: - Private methods:
    private func setupUI() {
        
        trackImage.layer.cornerRadius = trackImage.frame.height / 10
        trackImage.fetchImage(from: infoTrack?.albumPicture ?? "")
        
        albumNameLabel.text = infoTrack?.collectionName
        currencyPriceTrackLabel.text =
        "\(infoTrack?.trackPrice ?? 0) \(infoTrack?.currency ?? "")"
        trackNameLabel.text = infoTrack?.trackName
        artistNameLabel.text = infoTrack?.artistName
    }
}
