//
//  Transaction+CoreDataProperties.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var payments: NSSet?
    @NSManaged public var persons: NSSet?
    @NSManaged public var name: String?

}

// MARK: Generated accessors for payments
extension Transaction {

    @objc(addPaymentsObject:)
    @NSManaged public func addToPayments(_ value: Payment)

    @objc(removePaymentsObject:)
    @NSManaged public func removeFromPayments(_ value: Payment)

    @objc(addPayments:)
    @NSManaged public func addToPayments(_ values: NSSet)

    @objc(removePayments:)
    @NSManaged public func removeFromPayments(_ values: NSSet)

}

// MARK: Generated accessors for persons
extension Transaction {

    @objc(addPersonsObject:)
    @NSManaged public func addToPersons(_ value: Person)

    @objc(removePersonsObject:)
    @NSManaged public func removeFromPersons(_ value: Person)

    @objc(addPersons:)
    @NSManaged public func addToPersons(_ values: NSSet)

    @objc(removePersons:)
    @NSManaged public func removeFromPersons(_ values: NSSet)

}
