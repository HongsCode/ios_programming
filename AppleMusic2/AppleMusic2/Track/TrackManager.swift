//
//  TrackManager.swift
//  AppleMusic2
//
//  Created by HongYeol on 2020/07/27.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit
import AVFoundation

//Track ViewModel
//Track Manager 관리
class TrackManager {
    var tracks:[AVPlayerItem] = []
    var albums:[Album] = []
    var todayTrack:AVPlayerItem?

    init() {
        tracks = loadTrack()
        albums = loadAlbum(tracks: tracks)
        todayTrack = self.tracks.randomElement()
    }
    
    func loadTrack() -> [AVPlayerItem] {
        let urls = Bundle.main.urls(forResourcesWithExtension: ".mp3", subdirectory: nil) ?? []
        
        //url을 돌면서 가져와야함, map(고차함수)
        
        let items = urls.map { url -> AVPlayerItem in
            let item = AVPlayerItem(url:url)
            return item
        }
        return items
    }
    
    func loadAlbum(tracks:[AVPlayerItem]) -> [Album] {
        //map은 만들때 조건에 맞지 않으면 nil을 넣지만,
        //compact map은 조건에 맞지 않으면 빼버림
        /*let trackList:[Track] = tracks.map { track -> Track in {
            return track.convertToTrack()
            }*/
        let trackList:[Track] = tracks.compactMap {
            track -> Track in
            let item = track.convertToTrack()
            return item!
        }
        let albumDics = Dictionary(grouping: trackList, by: {(track) in track.albumName})
        var albums:[Album] = []
        
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title:title, tracks:tracks)
            albums.append(album)
        }
        return albums
    }
    
    func loadOtherTodaysTrack() {
        self.todayTrack = self.tracks.randomElement()
    }
    
    func track(at index:Int) -> Track? {
        let playerItem = tracks[index]
        let track = playerItem.convertToTrack()
        return track
    }
}
