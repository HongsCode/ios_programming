//
//  BountyViewModel.swift
//  BountyListPractice
//
//  Created by HongYeol on 2020/07/23.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

class BountyViewModel {
    let bountyList:[BountyInfo] = [
        BountyInfo(name:"brook", bounty:33000000),
        BountyInfo(name:"chopper", bounty:50),
        BountyInfo(name:"franky", bounty:44000000),
        BountyInfo(name:"luffy", bounty:300000000),
        BountyInfo(name:"nami", bounty:16000000),
        BountyInfo(name:"robin", bounty:80000000),
        BountyInfo(name:"sanji", bounty:77000000),
        BountyInfo(name:"zoro", bounty:120000000)
    ]
    
    var sortedList:[BountyInfo] {
        /*let sortedList = bountyList.sorted() {
            (first, second) in return first.bounty > second.bounty
        }
        return sortedList*/
        let sortedList = bountyList.sorted(by: {
            (first:BountyInfo, second: BountyInfo) in return first.bounty > second.bounty
        })
        return sortedList
    }
// 클로저인데, 할당하는 부분 알아볼것
//    var sortedList2:[BountyInfo] = bountyList.sorted() {
//        return $0.bounty > $1.bounty
//    }
    func getBountyInfo(at index:Int) throws -> BountyInfo {
        if (index < 0 || index > numOfBountyInfo()) {
            throw BountyInfoError.InvalidCase
        }
        return bountyList[index]
    }
    
    func numOfBountyInfo() -> Int {
        return bountyList.count
    }
}
