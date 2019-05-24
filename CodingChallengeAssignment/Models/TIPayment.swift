//
//  TIPayment.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import Foundation

class TIPayment: Equatable {
    
    static func == (lhs: TIPayment, rhs: TIPayment) -> Bool {
        return lhs.person.name == rhs.person.name
    }
    
    var person : TIPerson!
    var amount: TIMoney!
    
    class func paymentWithPerson(_ person : TIPerson, amount: TIMoney) -> TIPayment{
        
        let payment = TIPayment.init()
        payment.person = person
        payment.amount = amount
        return payment
    }
    
    class func paymentFromCDPayment(_ paymeny: Payment) -> TIPayment {
        
        return TIPayment.paymentWithPerson(TIPerson.personFromCDPerson(paymeny.person!), amount: TIMoney.moneyWithValue(Int(paymeny.amount)))
    }

}

