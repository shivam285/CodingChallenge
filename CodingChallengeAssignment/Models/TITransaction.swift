//
//  TITransaction.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import Foundation

class TITransaction: NSObject {
    
    var name: String!
    var payments = [TIPayment]()
    var persons = [TIPerson]()
    var amount : TIMoney!
    var involved: [TIPayment]?
    var unInvolved: [TIPayment]?
    
    class func transactionWithName(_ name: String, payments: [TIPayment], persons: [TIPerson]) -> TITransaction{
        
        if payments.count <= 0 {
            return TITransaction()
        }
        
        let transaction = TITransaction()
        transaction.name = name
        transaction.persons = persons
        transaction.payments = payments
        
        var totalMoney: Int! = 0
        
        for paymeny in payments {
            totalMoney = totalMoney + paymeny.amount.amount
        }
        
        let money = TIMoney(amount: totalMoney)
        transaction.amount = money
        
        var involved =  [TIPayment]()
        var unInvolved =  [TIPayment]()

        for payment in payments {
            if persons.contains(payment.person) {
                involved.append(payment)
            }else {
                unInvolved.append(payment)
            }
        }
        
        transaction.involved = involved
        transaction.unInvolved = unInvolved
        
        return transaction
        
    }
    
    class func transactionFromCDTransaction(_ transaction: Transaction) -> TITransaction {
        
        var payments = [TIPayment]()
        var persons = [TIPerson]()
        
        if let paymentsArray = transaction.payments?.allObjects as? [Payment] {
            for payment in paymentsArray {
                let tiPayment = TIPayment.paymentFromCDPayment(payment)
                payments.append(tiPayment)
            }
        }
        
        if let personsArray = transaction.persons?.allObjects as? [Person] {
            for person in personsArray {
                let tiPerson = TIPerson.personFromCDPerson(person)
                persons.append(tiPerson)
            }
        }
        
        return TITransaction.transactionWithName(transaction.name!, payments: payments, persons: persons)
    }
    
    class func getResult(transaction: TITransaction,  completionHandler: @escaping (([TIPerson], [TIPerson]) -> Void)) {
        
        let finalTransaction  = transaction
        
        let totalAmnt = finalTransaction.amount.amount
        let shouldPay = totalAmnt! / PersonInfo.count.rawValue
        
        var primaryPerson: TIPerson!
        
        var lendees = [TIPerson]()
        var lenders = [TIPerson]()
        
        for person in finalTransaction.persons {
            if person.name == "A" {
                primaryPerson = person
            }
        }
        
        var delta = 0
        
        for eachPayment in finalTransaction.payments {
            
            if eachPayment.person.name == primaryPerson.name {
                delta = eachPayment.amount.amount - shouldPay
                
            }
        }
        
        let payments = finalTransaction.payments.sorted { return $0.person.id  < $1.person.id }
        
        for eachPayment in payments {
            
            if eachPayment.person.name != primaryPerson.name {
                if delta >= 0 {
                    
                    //+ve
                    let amountLeft = eachPayment.amount.amount - shouldPay
                    if amountLeft < 0 {
                        if delta < abs(Int32(amountLeft)) {
                            eachPayment.person.amountDue = delta
                            delta = 0
                        }else {
                            delta = delta + amountLeft
                            eachPayment.person.amountDue = (-amountLeft)
                        }
                        lendees.append(eachPayment.person)
                        
                    }else {
                        continue
                    }
                }else {
                    //-ve
                    let amountLeft = eachPayment.amount.amount - shouldPay
                    
                    if amountLeft > 0 {
                        if abs(Int32(delta)) >=  amountLeft{
                            delta = Int(abs(Int32(delta))) - amountLeft
                            eachPayment.person.amountDue =  (-amountLeft)
                            lenders.append(eachPayment.person)
                        }
                    }else {
                        continue
                    }
                    
                }
                
                if delta == 0 {
                    completionHandler(lendees, lenders)
                    return
                }
                
            }
        }
        
        completionHandler(lendees, lenders)
    }
}
