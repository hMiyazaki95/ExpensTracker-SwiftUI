//
//  TransactionListViewModel.swift
//  ExpensTracker
//
//  Created by Hajime Miyazaki on 6/11/24.
//

import Foundation
import SwiftUI
import Combine

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            // A tuple is a pair of values grouped into a single one and is recognized by parentheses separated by a comma
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in 
                switch completion {
                case .failure(let error):
                    print("Error fetching transaction", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions:")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)
    }
}
