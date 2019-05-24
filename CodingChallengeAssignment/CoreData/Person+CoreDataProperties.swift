//
//  Person+CoreDataProperties.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var transactions: NSSet?
    @NSManaged public var paymentMade: NSSet?

}

// MARK: Generated accessors for transactions
extension Person {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

// MARK: Generated accessors for paymentMade
extension Person {

    @objc(addPaymentMadeObject:)
    @NSManaged public func addToPaymentMade(_ value: Payment)

    @objc(removePaymentMadeObject:)
    @NSManaged public func removeFromPaymentMade(_ value: Payment)

    @objc(addPaymentMade:)
    @NSManaged public func addToPaymentMade(_ values: NSSet)

    @objc(removePaymentMade:)
    @NSManaged public func removeFromPaymentMade(_ values: NSSet)

}
