//
//  BountyViewController.swift
//  BountyListPractice
//
//  Created by HongYeol on 2020/07/23.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

class BountyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let bountyViewModel = BountyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bountyViewModel.numOfBountyInfo()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        do {
            try cell.update(info:bountyViewModel.getBountyInfo(at: indexPath.item))
        } catch {
            print(error)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpace:CGFloat = 10
        let textHeight:CGFloat = 65
        
        let width:CGFloat = (collectionView.bounds.width - itemSpace) / 2
        let height:CGFloat = width * 10 / 7 + textHeight
        
        return CGSize(width:width, height:height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue.destination = \(segue.destination), identifier = \(segue.identifier)" )
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                do {
                    try vc?.bountyModel.updateModel(model: bountyViewModel.getBountyInfo(at: index))
                } catch {
                    print(error)
                }
            }
        }
    }
}

class GridCell:UICollectionViewCell {

    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    func update(info:BountyInfo) {
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
        imgView.image = info.image
    }
}
