//
//  NewTransactionViewModel.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import CoreData

struct NewTransactionViewModelInitParams{
    var cdContext: NSManagedObjectContext!
}

class NewTransactionViewModel: NSObject {
    
    var viewDelegate:NewTransactionViewModelDelegate?
    
    var personAAmount: Int! = 0
    var personBAmount: Int! = 0
    var personCAmount: Int! = 0
    var personDAmount: Int! = 0
    var personEAmount: Int! = 0
    var transactionName: String!
    
    var navBarTitle: String {
        return "Add new Trx"
    }
    
    var cdContext: NSManagedObjectContext!
 
    //MARK:- Initialization methods
    init(params: NewTransactionViewModelInitParams) {
        self.cdContext = params.cdContext
    }
    
    func saveButtonPressed() {
        
        let paymentA = Payment(context: cdContext)
        paymentA.amount = Int64(personAAmount)
        let person = Person(context: cdContext)
        person.id = PersonInfo.A.personId
        person.name = PersonInfo.A.personName
        paymentA.person = person
        
        let paymentB = Payment(context: cdContext)
        paymentB.amount = Int64(personBAmount)
        let personB = Person(context: cdContext)
        personB.id = PersonInfo.B.personId
        personB.name = PersonInfo.B.personName
        paymentB.person = personB
        
        let paymentC = Payment(context: cdContext)
        paymentC.amount = Int64(personCAmount)
        let personC = Person(context: cdContext)
        personC.id = PersonInfo.C.personId
        personC.name = PersonInfo.C.personName
        paymentC.person = personC
        
        let paymentD = Payment(context: cdContext)
        paymentD.amount = Int64(personDAmount)
        let personD = Person(context: cdContext)
        personD.id = PersonInfo.D.personId
        personD.name = PersonInfo.D.personName
        paymentD.person = personD
        
        
        let paymentE = Payment(context: cdContext)
        paymentE.amount = Int64(personEAmount)
        let personE = Person(context: cdContext)
        personE.id = PersonInfo.E.personId
        personE.name = PersonInfo.E.personName
        paymentE.person = personE
        
        let transaction = Transaction(context: cdContext)
        transaction.name = transactionName
        transaction.addToPersons(NSSet(array: [person, personB, personC, personD, personE]))
        transaction.addToPayments(NSSet(array: [paymentA, paymentB, paymentC,paymentD, paymentE]))
        saveContext(cdContext: cdContext)
        
        viewDelegate?.transactionAddedSuccessfully()
        
    }
    
    //MARK: - filePrivate methods
    fileprivate func saveContext(cdContext:NSManagedObjectContext) {
        CoreDataStack.saveSyncMOC(cdContext, cascadeSave: true)
    }
}
