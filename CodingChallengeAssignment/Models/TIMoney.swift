//
//  TIMoney.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import Foundation

class TIMoney: NSObject {
    
    var amount: Int!
    
    init(amount: Int) {
        self.amount = amount
    }
    
    class func moneyWithValue(_ value: Int) -> TIMoney {
        return TIMoney.init(amount: value)
    }
}
