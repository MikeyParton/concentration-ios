//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Parton on 2/7/18.
//  Copyright © 2018 Michael Parton. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    var lastFlippedCards = 0
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func touchNewGameButton(_ sender: Any) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        newGameButton.isHidden = true
        flipCount = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func updateViewFromModel() {
        guard cardButtons != nil else { return }
        var flippedCards = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                flippedCards += 1
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
        }
        
        if flippedCards != lastFlippedCards {
            flipCount += 1
        }
        lastFlippedCards = flippedCards
        
        if game.gameOver {
            newGameButton.isHidden = false
        }
    }
    
    var emojiChoices = ["👻", "🎃", "😈", "💀", "🙀", "👹"]
    
    var theme: [String]? {
        didSet {
            emojiChoices = theme ?? []
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        print(card.identifier)
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
}

