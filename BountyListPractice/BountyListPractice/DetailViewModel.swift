//
//  DetailViewModel.swift
//  BountyListPractice
//
//  Created by HongYeol on 2020/07/23.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

class DetailViewModel {
    var bountyInfo:BountyInfo?
    func updateModel(model:BountyInfo?) {
        self.bountyInfo = model
    }

}
