//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by apple on 2020/10/2.
//

import Foundation

struct PlayCardDeck {
    
    private(set) var cards = [PlayingCard].init()
    
    init() {
        for suit in PlayingCard.Suit.all { 
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
        cards.sort(by: <)
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.random)
        }
        return nil
    }
}

// MARK: - 拓展Int
extension Int {
    // 使random返回(0，self)的随机整数
    var random: Int {
        if self == 0 { return 0 }
        return Int(arc4random_uniform(UInt32(abs(self))))
    }
}
