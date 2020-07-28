//
//  DetailViewController.swift
//  BountyListPractice
//
//  Created by HongYeol on 2020/07/23.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var bountyModel = DetailViewModel()
    
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bounty: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
        //layout의 contant를 이용해서 animate를 하는 경우
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //layout의 contant를 이용해서 animate를 하는 경우
        showAnimation()
        
    }
    
    func prepareAnimation() {
        //nameLabelCenterX.constant 0....
        //nameLabelCenterX.constant = view.bounds.width
        //bountyLabelCenterX.constant = view.bounds.width
        
        //view 속성을 이용하여 animation
        name.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        bounty.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        
        name.alpha = 0
        bounty.alpha = 0
    }
    func showAnimation() {
        //constant 이용한 animation
        //nameLabelCenterX.constant = 0
        //bountyLabelCenterX.constant = 0
        
        //UIView.animate(withDuration: 0.3, animations: <#T##() -> Void#>)
        /*UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }*/
        /*UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)*/
        
        /*UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {self.view.layoutIfNeeded()}, completion: nil)
        
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)*/
        
        //View Animation, Auto layout과 충돌 날 수도 있다!!!!!!조심해서 사용해야함
        //변형을 가하기 전의 모습을. identity로 얻을 수 있음
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            self.name.transform = CGAffineTransform.identity
            self.name.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            self.bounty.transform = CGAffineTransform.identity
            self.bounty.alpha = 1
        }, completion: nil)
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }

    func updateUI() {
        if let bInfo = bountyModel.bountyInfo {
            imgView.image = bInfo.image
            name.text = bInfo.name
            bounty.text = "\(bInfo.bounty)"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
