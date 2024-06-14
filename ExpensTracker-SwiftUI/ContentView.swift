//
//  ContentView.swift
//  ExpensTracker
//
//  Created by Hajime Miyazaki on 6/11/24.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    // temporary data set
    //var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    //Mark: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //MARK: Chart
                    let data = transactionListVM.accumulateTransactions()
                    // add logic to check if the data is not empty before even displaying the chart
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        
                        CardView {
                            VStack(alignment: .leading) {
                                // ChartLabel("$900", type: .title)
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "$%.02")
                                
                                LineChart() // the line chart shows a history of cumulative total expenses per day within the current month
                            }
                            .background(Color.customSystemBackground)
                        }
                        //.data(demoData) // item requires double or tupple. check the data
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.customSystemBackground, foregroundColor: ColorGradient(Color.customIcon.opacity(0.4), Color.customIcon))).frame(height: 300)
                    }
                    
                    //MARK: Transaction List
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: . infinity)
                    
                    
            }
            .background(Color.customBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //MARK: Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.customIcon, .primary) // from the Extensions.swift. this grab the color from the Assets.xcassets
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
