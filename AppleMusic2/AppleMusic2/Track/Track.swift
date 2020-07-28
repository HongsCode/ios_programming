//
//  Track.swift
//  AppleMusic2
//
//  Created by HongYeol on 2020/07/27.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

//Track Model

struct Track {
    let title:String
    let artist:String
    let albumName:String
    let artwork:UIImage
    
    init(title:String, artist:String, albumName:String, artwork:UIImage) {
        self.title = title
        self.artist = artist
        self.albumName = albumName
        self.artwork = artwork
    }
}

struct Album {
    let title:String
    let tracks:[Track]
    
    var thumbnail:UIImage? {
        return tracks.first?.artwork
    }
    
    var artist:String? {
        return tracks.first?.title
    }
    
    init(title:String, tracks:[Track]) {
        self.title = title
        self.tracks = tracks
    }
}
