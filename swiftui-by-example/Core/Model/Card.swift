//
//  Card.swift
//  swiftui-by-example
//
//  Created by loratech on 09/02/24.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    var id: UUID = .init()
    var bgColor: Color
    var balance: String
}

extension Card {
    static let MOCK_CARDS:[Card] = [
        .init(bgColor: .red, balance: "$123232"),
        .init(bgColor: .blue, balance: "$9099"),
        .init(bgColor: .orange, balance: "$78666"),
        .init(bgColor: .purple, balance: "$8980")
    ]
}
