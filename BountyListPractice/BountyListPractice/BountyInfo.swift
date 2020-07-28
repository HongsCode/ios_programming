//
//  BountyInfo.swift
//  BountyListPractice
//
//  Created by HongYeol on 2020/07/23.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

class BountyInfo {
    var name:String
    var bounty:Int
    
    var image:UIImage? {
        return UIImage(named:"\(self.name).jpg")
    }
    init(name:String, bounty:Int) {
        self.name = name
        self.bounty = bounty
    }
}
enum BountyInfoError:Error {
    case InvalidCase
}

enum BountyError:Error {
    case InvalidNumber
}
