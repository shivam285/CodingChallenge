//
//  HomeRelatedEnums.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import Foundation

enum PersonInfo : Int {
    
    case A, B, C, D, E, count
    
    static var names = [A : "A", B: "B", C: "C", D:"D", E: "E", count: ""]
    
    static var ids = [A : "1", B: "2", C: "3", D:"4", E: "5", count: ""]

    var personName: String{
        if let name = PersonInfo.names[self]{
            return name
        }
        return ""
    }
    
    var personId: String{
        if let id = PersonInfo.ids[self]{
            return id
        }
        return ""
    }
    
}
