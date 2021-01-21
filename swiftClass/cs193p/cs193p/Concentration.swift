//
//  Concentration.swift
//  cs193p
//
//  Created by apple on 2020/9/17.
//  Copyright © 2020 史圣久. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
//            let faceUpCardIndices = cards.indices.filter { (index) -> Bool in
//                cards[index].isFaceUp
//            }
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        
        set(newValue) {
            for Index in cards.indices {
                cards[Index].isFaceUp = (Index == newValue)
//                if Index != newValue {
//                    cards[Index].isFaceUp = false
//                } else {
//                    cards[Index].isFaceUp = true
//                }
            }
        }
    }
    
    static var lastCards: Int!
    
    mutating func chooseCard(at index: Int) -> Int{
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if cards[index].isMatch { return 0 }
        if let matchIndex = indexOfOneAndOnlyFaceUpCard{
            if matchIndex != index {
                cards[index].isFaceUp = true
                // 检查是否匹配
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                    Concentration.lastCards -= 1
                    if Concentration.lastCards == 0 {
                        NSLog("finish")
                        for flipDownIndex in cards.indices {
                            cards[flipDownIndex].isFaceUp = false
                        }
                    }
                }
                return 1
            }
            return 0
        } else {
            // 没有卡片是正面 或有两张卡片匹配成功
            indexOfOneAndOnlyFaceUpCard = index
            return 1
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair or cards")
        Concentration.lastCards = numberOfPairsOfCards
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        randomCards()
    }
    
    //洗牌算法
    mutating func randomCards() {
        for Index in cards.indices.reversed() {
            // 从0-i随机选一个数r，交换i和r
            let rand = Int(arc4random_uniform(UInt32(Index)))
            cards.swapAt(Index, rand)
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
