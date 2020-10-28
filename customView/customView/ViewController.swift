//
//  ViewController.swift
//  customView
//
//  Created by HongYeol on 2020/10/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var header: headerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension ViewController:headerDelegate {
    func onSwitch(isOn: Bool) {
        print("ViewController onSwitch \(isOn)")
    }
    
    
}
