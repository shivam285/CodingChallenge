//
//  TIPerson.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import Foundation

class TIPerson: Equatable {
    
    static func == (lhs: TIPerson, rhs: TIPerson) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var name: String!
    var id: String!
    var amountDue: Int?

    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    class func personFromCDPerson(_ person : Person) -> TIPerson{
        return TIPerson(name: person.name!, id: person.id!)
    }
    
}
