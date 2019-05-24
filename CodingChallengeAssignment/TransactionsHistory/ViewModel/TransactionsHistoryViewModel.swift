//
//  TransactionsHistoryViewModel.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import UIKit
import CoreData

struct TransactionsHistoryViewModelInitParams{
    var cdContext: NSManagedObjectContext!
}

class TransactionsHistoryViewModel: NSObject {
    
    var viewDelegate:TransactionsHistoryViewModelDelegate?
    var cdContext: NSManagedObjectContext!
    var tiTransactions = [TITransaction]()

    var cellIdentifier: String {
        return "TransactionsHistoryCell"
    }
    
    var navBarTitle: String {
        return "All Tx Info"
    }
    
    var itemViewModels: [TransactionHistoryItemViewModel]?
    
    //MARK:- Initialization methods
    init(params:TransactionsHistoryViewModelInitParams){
        self.cdContext = params.cdContext
    }
    
    func fetchAllTransactions() {
        
        guard  let transactions = Transaction.findAll(context: cdContext), transactions.count > 0 else { return }
        
        var tiTransactions = [TITransaction]()
        
        for transaction in transactions {
            let tiTRansaction = TITransaction.transactionFromCDTransaction(transaction)
            tiTransactions.append(tiTRansaction)
        }
        
        self.tiTransactions = tiTransactions
        self.populateItemViewModels()
        self.viewDelegate?.reloadTableView()
    }
    
    //MARK: - fileprivate methods
    fileprivate func populateItemViewModels() {
        
        itemViewModels = [TransactionHistoryItemViewModel]()
        
        for transaction in tiTransactions {
            let itemViewModel = TransactionHistoryItemViewModel(transaction:transaction)
            self.itemViewModels?.append(itemViewModel)
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TransactionsHistoryViewModel {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemViewModels?.count ?? 0
    }
}
