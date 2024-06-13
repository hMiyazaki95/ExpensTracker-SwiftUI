//
//  PreviewData.swift
//  ExpensTracker
//
//  Created by Hajime Miyazaki on 6/11/24.
//

import Foundation
import SwiftUI

// this is the first api data set will be called on
var transactionPreviewData = Transaction(id: 1, date: "06/11/2022,", institution: "Desjardins", account: "Visa Disjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

// a tip is to repeat a data type as how many times as you want
var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
                                  
