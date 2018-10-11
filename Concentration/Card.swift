//
//  Card.swift
//  Concentration
//
//  Created by Michael Parton on 3/7/18.
//  Copyright © 2018 Michael Parton. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var wasFlipped = false
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static var uniqueIdentifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        uniqueIdentifierFactory += 1
        return uniqueIdentifierFactory
    }
}
