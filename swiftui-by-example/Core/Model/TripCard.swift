//
//  TripCard.swift
//  swiftui-by-example
//
//  Created by loratech on 09/02/24.
//

import Foundation

struct TripCard: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var image: String
}

extension TripCard {
    static let MOCK_TRIP_CARDS: [TripCard] = [
        .init(title: "London", subtitle: "England", image: "pic-1"),
        .init(title: "Bali", subtitle: "Indonesia", image: "pic-2"),
        .init(title: "Pukhat", subtitle: "Thailand", image: "pic-3"),
        .init(title: "Rinjani", subtitle: "Indonesia", image: "pic-4"),
        .init(title: "New York", subtitle: "United Stated", image: "pic-5"),
        .init(title: "Dubai", subtitle: "UAE", image: "pic-6"),
        .init(title: "Mekka", subtitle: "Saudi Arabia", image: "pic-7"),
        .init(title: "Kuala Lumpur", subtitle: "Malaysia", image: "pic-8"),
        .init(title: "Tokyo", subtitle: "Japan", image: "pic-9"),
        .init(title: "Seou", subtitle: "South Korea", image: "pic-10")
    ]
}
