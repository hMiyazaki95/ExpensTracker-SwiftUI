//
//  ExpensTrackerApp.swift
//  ExpensTracker
//
//  Created by Hajime Miyazaki on 6/11/24.
//

import SwiftUI

@main
struct ExpensTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
