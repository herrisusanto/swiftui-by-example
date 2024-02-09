//
//  Expense.swift
//  swiftui-by-example
//
//  Created by loratech on 09/02/24.
//

import Foundation

struct Expense: Identifiable {
    var id: UUID = UUID()
    var amountSpent: String
    var product: String
    var spendType: String
}

extension Expense {
    static var MOCK_EXPENSES: [Expense] = [
        .init(amountSpent: "$124", product: "Amazon Purchase", spendType: "Groceries"),
        .init(amountSpent: "$33", product: "Youtube Premium", spendType: "Streaming"),
        .init(amountSpent: "$10", product: "Dribble", spendType: "Membership"),
        .init(amountSpent: "$124", product: "Amazon Purchase", spendType: "Groceries"),
        .init(amountSpent: "$33", product: "Youtube Premium", spendType: "Streaming"),
        .init(amountSpent: "$10", product: "Dribble", spendType: "Membership"),
        .init(amountSpent: "$124", product: "Amazon Purchase", spendType: "Groceries"),
        .init(amountSpent: "$33", product: "Youtube Premium", spendType: "Streaming"),
        .init(amountSpent: "$10", product: "Dribble", spendType: "Membership")
    
    ]
}
