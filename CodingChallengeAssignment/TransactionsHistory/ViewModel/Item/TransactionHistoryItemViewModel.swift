//
//  TransactionHistoryItemViewModel.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/25/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import Foundation

class TransactionHistoryItemViewModel: NSObject {
    
    var transaction: TITransaction!
    
    init(transaction: TITransaction) {
        self.transaction = transaction
    }
    
}
