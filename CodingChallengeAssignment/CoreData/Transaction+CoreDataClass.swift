//
//  Transaction+CoreDataClass.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {

    public class func findOne(transactionId: String, context: NSManagedObjectContext) -> Transaction? {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.predicate = NSPredicate.init(format: "Transaction=%@", transactionId)
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                return results[0]
            }
        } catch {
            fatalError("Failed to find Transaction: \(error)")
        }
        return nil
    }
    
    public class func removeAll() {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        let context = CoreDataStack.getSharedMOC()
        
        do {
            let results = try context.fetch(request)
            for object in results {
                CoreDataStack.getSharedMOC().delete(object)
            }
        } catch {
            fatalError("Failed to find Patient: \(error)")
        }
    }
    
    public class func findAll(context: NSManagedObjectContext) -> [Transaction]? {
        
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        
        do {
            let results = try context.fetch(request)
            return results
        } catch {
            fatalError("Failed to find Transaction: \(error)")
        }
        return nil
    }
}
