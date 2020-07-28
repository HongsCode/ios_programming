//
//  TrackCollectionHeaderView.swift
//  AppleMusic2
//
//  Created by HongYeol on 2020/07/27.
//  Copyright © 2020 HY. All rights reserved.
//



import UIKit
import AVFoundation

class TrackCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var trackThumbnail:UIImageView!
    @IBOutlet weak var trackDescription:UILabel!

    var item:AVPlayerItem?
    var tapHandler:((AVPlayerItem) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        trackThumbnail?.layer.cornerRadius = 4
    }
    
    func update(with item:AVPlayerItem) {
        self.item = item
        guard let track = item.convertToTrack() else { return }
        
        self.trackThumbnail.image = track.artwork
        self.trackDescription.text = "Toady's Pick is \(track.artist)'s album - \(track.albumName), Let's listen."
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        
    }
}
