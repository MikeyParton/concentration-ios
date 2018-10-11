//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Parton on 3/7/18.
//  Copyright © 2018 Michael Parton. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var indexOfFirstChoice: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpCardIndices.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (newValue == index)
            }
        }
    }
    
    var numberOfPairsOfCards: Int
    var matches = 0
    var gameOver = false
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfFirstChoice, matchIndex != index {
                print("checking for a match")
                // Check for a match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matches += 1
                    if matches == numberOfPairsOfCards {
                        gameOver = true
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfFirstChoice = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    func shuffleCards() {
        var shuffledCards = [Card]()
        for _ in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        cards = shuffledCards
    }    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
