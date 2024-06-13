//
//  RecentTransactionList.swift
//  ExpensTracker
//
//  Created by Hajime Miyazaki on 6/12/24.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        //1
        VStack {
            HStack {
                //MARK: Header Title
                Text("Recent Transaction").bold()
                //MARK: Header Link
                NavigationLink {
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            //MARK: Recent Transaction List
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element) {index,
                transaction in TransactionRow(transaction: transaction)
                
                Divider()
                    // this eliminates the devider under the last element in preview
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.customSystemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius:10, x:0, y:5)
    }
    
}

struct RecentTransactionList_Previews: PreviewProvider {
    // implemented like datafommarter in the Extension.swift
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group {
            RecentTransactionList()
            RecentTransactionList().preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
