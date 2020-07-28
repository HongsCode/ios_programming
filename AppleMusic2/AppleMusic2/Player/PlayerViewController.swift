//
//  PlayerViewController.swift
//  AppleMusic2
//
//  Created by HongYeol on 2020/07/27.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet var tileSlider: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var playerControllButton: UIButton!
    
    var timeObserver:Any?
    var isSeeking:Bool = false
    
    //Simplay
    let simplePlayer = SimplePlayer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        updateTrackInfo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        simplePlayer.pause()
        simplePlayer.replaceCurrentItem(with: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func togglePlayButton(_ sender:Any) {
        if simplePlayer.isPlaying {
            simplePlayer.pause()
        } else {
            simplePlayer.play()
        }
        updatePlayerButton()
        
    }

}

extension PlayerViewController {

    func updateTrackInfo() {
        guard let track = simplePlayer.currentItem?.convertToTrack() else {
            return
        }
        
        thumbnailImageView.image = track.artwork
        titleLabel.text = track.title
        artistLabel.text = track.artist
    }
    func secondsToString(sec:Double) -> String {
        guard sec.isNaN == false else { return "00:00" }
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
    func updatePlayerButton() {
        if simplePlayer.isPlaying {
            let configuration = UIImage.SymbolConfiguration(pointSize:40)
            let image = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            playerControllButton.setImage(image, for: .normal)
        } else {
            let configuration = UIImage.SymbolConfiguration(pointSize:40)
            let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
            playerControllButton.setImage(image, for: .normal)

        }
    }
}
