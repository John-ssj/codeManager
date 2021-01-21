//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by apple on 2020/10/2.
//

import Foundation

struct PlayingCard: Hashable, CustomStringConvertible {
    
    // 在符合CustomStringConvertible协议之后可以用description自定义print时的输出形式
    var description: String { return "\(suit)\(rank)"}
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(CardValue)
        // 根据combine内容生成的hash值作为唯一的标识符（并不是直接以combine的内容作为标识）
    }
    
    /*
     在符合hashalbe协议之后可以用==, <, >直接比较两个元素的大小
     可通过如下函数自定义（默认比较两个元素的hashValue）
     */
    static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.CardValue == rhs.CardValue
    }
    
    static func < (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
//        return (lhs.rank == rhs.rank) ? (lhs.suit < rhs.suit) : (lhs.rank < rhs.rank)
        return lhs.CardValue < rhs.CardValue
    }
    
    // MARK: - Card结构定义
    
    var suit: Suit
    var rank: Rank
    
    var CardValue: Int {
        (rank.order-1)*4+suit.order
    }
    
    
    // MARK: - Suit卡牌花色
    enum Suit: String, Hashable, CustomStringConvertible {
        var description: String { return "\(self.rawValue)" }
        
        case spades = "♠️"
        case haerts = "♥️"
        case diamonds = "♣️"
        case clubs = "♦️"
        
        // 花色大小比较
        var order:Int {
            switch self {
            case .clubs: return 0
            case .diamonds: return 1
            case .haerts: return 2
            case .spades: return 3
            }
        }
        
        // 所有花色集合
        static var all = [Suit.spades, .haerts, .diamonds, .clubs]
        
        static func < (lhs: Suit, rhs: Suit) -> Bool {
            return lhs.order < rhs.order
        }
    }
    
    // MARK: - Rank卡牌牌面
    enum Rank: CustomStringConvertible {
        var description: String { return "\(self.show)" }
        
        case ace
        case face(String)
        case numeric(Int)
        
        var num:Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips):
                return (2<=pips && pips<=10) ? pips : 0
            case .face(let kind):
                if      kind == "J" { return 11 }
                else if kind == "Q" { return 12 }
                else if kind == "K" { return 13 }
                else                { return 0  }
            }
        }
        
        // 牌面大小比较
        var order:Int {
            switch self {
            case .ace: return 14
            case .numeric(let pips):
                if pips == 2 { return 15 }
                return (2<=pips && pips<=10) ? pips : 0
            case .face(let kind):
                if      kind == "J" { return 11 }
                else if kind == "Q" { return 12 }
                else if kind == "K" { return 13 }
                else                { return 0  }
            }
        }
        
        // 牌面展示
        var show:String {
            switch self {
            case .ace: return "A"
            case .numeric(let pips):
                assert(2<=pips && pips<=10, "Card'rank:numeric(\(pips)) out of range!")
                return String(pips)
            case .face(let kind):
                assert(["J","Q","K"].contains(kind), "Card'rank:face(\(kind)) not exist!")
                return kind
            }
        }
        
        // 所有牌面集合
        static var all:[Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(.numeric(pips))
            }
            allRanks += [.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
        
        static func == (lhs: Rank, rhs: Rank) -> Bool {
            return lhs.order < rhs.order
        }
        
        static func < (lhs: Rank, rhs: Rank) -> Bool {
            return lhs.order < rhs.order
        }
    }
    
}
