//
//  TrackCollectionViewCell.swift
//  AppleMusic2
//
//  Created by HongYeol on 2020/07/27.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trackThumbnail:UIImageView!
    @IBOutlet weak var trackTitle:UILabel!
    @IBOutlet weak var trackArtist:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trackThumbnail.layer.cornerRadius = 4
        //trackArtist.textColor = UIColor.systemGray2
    }
    func updateUI(item:Track?) {
        guard let track = item else { return }
        trackThumbnail.image = track.artwork
        trackTitle.text = track.title
        trackArtist.text = track.artist
    }
}
