//
//  TransactionRow.swift
//  ExpensTracker
//
//  Created by Hajime Miyazaki on 6/11/24.
//

import SwiftUI
import SwiftUIFontIcon // importing package

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            // MARK: Transaction Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transaction Marchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                // MARK Transaction Date
                // calling the dateParsed in the Transactoin struct in the TransactionModel.swift
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // MARK: Transaction Ammount
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TransactionRow(transaction: transactionPreviewData)
            
            TransactionRow(transaction: transactionPreviewData)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}

