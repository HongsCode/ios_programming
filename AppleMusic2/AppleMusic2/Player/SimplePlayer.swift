//
//  SimplePlayer.swift
//  AppleMusic2
//
//  Created by HongYeol on 2020/07/27.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit
import AVFoundation

class SimplePlayer {
    
    static let shared = SimplePlayer()
    private let player = AVPlayer()
    var currentTime: Double {
        return player.currentItem?.currentTime().seconds ?? 0
    }
    var totalTime: Double {
        return player.currentItem?.duration.seconds ?? 0
    }
    var isPlaying: Bool {
        return player.isPlaying
    }
    var currentItem:AVPlayerItem? {
        return player.currentItem
    }
    
    init() {}
    
    func pause() {
        player.pause()
    }
    
    func play() {
        player.play()
    }
    
    func seek(to time:CMTime) {
        player.seek(to: time)
    }
    func replaceCurrentItem(with item:AVPlayerItem?) {
        player.replaceCurrentItem(with: item)
    }
    func addPeriodicTimeObserver(forInterbal:CMTime, quque:DispatchQueue?, using: @escaping (CMTime) -> Void) {
        player.addPeriodicTimeObserver(forInterval: forInterbal, queue: quque, using: using)
    }

}
