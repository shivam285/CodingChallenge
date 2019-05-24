//
//  TISplitCalculator.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import Foundation

class TISplitCalculator: NSObject {
    
    var transactions : [TITransaction]!
    var lendees = [TIPerson]()
    var lenders = [TIPerson]()
    
    class func calculatorWithTransactions(_ transactions: [TITransaction]) -> TISplitCalculator {
        
        let calculator = TISplitCalculator.init()
        
        calculator.transactions = transactions
        
        return calculator
        
    }
    
    func aggregateTransactions() -> TITransaction {
        
        var paymenys = [TIPayment]()
        var persons = [TIPerson]()
        
        for transaction in transactions {
            
            if let involved = transaction.involved {
                
                for payment in involved {
                    
                    if let itemIndex = paymenys.index(of: payment) {
                        let item = paymenys[itemIndex]
                        item.amount.amount  =  item.amount.amount + payment.amount.amount
                    }else {
                        paymenys.append(payment)
                        persons.append(payment.person)
                    }
                    
                }
            }
        }
        
        let transaction = TITransaction.transactionWithName("aggregate", payments: paymenys, persons: persons)
        return transaction
    }
    
    func getResult(completionHandler: @escaping (() -> Void)) {
        
        let aggregatedTransactions  = aggregateTransactions()
        
        let totalAmnt = aggregatedTransactions.amount.amount
        let shouldPay = totalAmnt! / PersonInfo.count.rawValue
        
        var primaryPerson: TIPerson!
        
        var lendees = [TIPerson]()
        var lenders = [TIPerson]()
        
        for person in aggregatedTransactions.persons {
            if person.name == "A" {
               primaryPerson = person
            }
        }
        
        var delta = 0
        
        for eachPayment in aggregatedTransactions.payments {
            
            if eachPayment.person.name == primaryPerson.name {
                delta = eachPayment.amount.amount - shouldPay
                
            }
        }
        
        let payments = aggregatedTransactions.payments.sorted { return $0.person.id  < $1.person.id }
        
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
                        }else {
                            eachPayment.person.amountDue =  delta
                            delta = 0
                            lenders.append(eachPayment.person)
                        }
                    }else {
                        continue
                    }
                    
                }
                
                if delta == 0 {
                    self.lendees = lendees
                    self.lenders = lenders
                    completionHandler()
                    return
                }
                
            }
        }
        
        self.lendees = lendees
        self.lenders = lenders
        completionHandler()
    }
    
    
}
