//
//  HomeItemViewModel.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import Foundation

class HomeItemViewModel: NSObject {
    
    var personInfo: PersonInfo!
    
    var amountDue : Int! = 0
    
    init(personInfo: PersonInfo) {
        self.personInfo = personInfo
    }
}
