//
//  HomeViewModel.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import UIKit
import CoreData

struct HomeViewModelInitParams {
    
}

class HomeViewModel: NSObject {
    
    var viewDelegate:HomeViewModelDelegate?
    
    var homeItemViewModels = [HomeItemViewModel]()
    
    var cellIdentifier: String {
        return "HomeViewModelCell"
    }
    
    var cdContext: NSManagedObjectContext!
    
    var lendees = [TIPerson]()
    var lenders = [TIPerson]()
    
    //MARK: - Initialization
    init(params: HomeViewModelInitParams) {
        cdContext = CoreDataStack.sharedInstance.newChildManagedObjectContext(ofContext: CoreDataStack.getSharedMOC())
    }
    
    func populateItemViewModels() {
        
        for i in 0...PersonInfo.count.rawValue {
            let personInfo = PersonInfo.init(rawValue:i)
            let itemViewModel = HomeItemViewModel(personInfo:personInfo!)
            self.homeItemViewModels.append(itemViewModel)
        }
        
    }
    
    func fetchAllResults() {
        
        guard  let transactions = Transaction.findAll(context: cdContext), transactions.count > 0 else { return }
        
        var tiTransactions = [TITransaction]()
        
        for transaction in transactions {
            let tiTRansaction = TITransaction.transactionFromCDTransaction(transaction)
            tiTransactions.append(tiTRansaction)
        }
        
        let calculator = TISplitCalculator.calculatorWithTransactions(tiTransactions)
        calculator.getResult() {
            
            self.lendees = calculator.lendees
            self.lenders = calculator.lenders
            
            self.viewDelegate?.reloadTableView()
        }
        
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension  HomeViewModel{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonInfo.count.rawValue
    }
    
    func getItemViewModel(indexPath: IndexPath) -> HomeItemViewModel{
        let personInfo = PersonInfo.init(rawValue: indexPath.row)
        let itemViewModel = HomeItemViewModel(personInfo:personInfo!)
        
        for lendee in lendees {
            if lendee.name == itemViewModel.personInfo.personName {
                itemViewModel.amountDue = lendee.amountDue
                return itemViewModel
            }
        }
        
        for lender in lenders {
            if lender.name == itemViewModel.personInfo.personName {
                itemViewModel.amountDue = lender.amountDue
                return itemViewModel
            }
        }
        return itemViewModel
    }
    
    func cellBackgroundColor(atIndexPath indexPath: IndexPath) -> UIColor{
        if indexPath.row % 2 == 0{
            return UIColor.black
        }else {
            return UIColor.darkGray
        }
    }
}
