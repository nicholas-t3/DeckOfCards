//
//  Card.swift
//  DeckOfCards
//
//  Created by Nicholas Towery on 11/17/20.
//

import Foundation

struct TopLevelObject: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let value: String
    let suit: String
    let image: URL
}
