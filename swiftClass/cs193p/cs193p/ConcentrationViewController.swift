//
//  ViewController.swift
//  cs193p
//
//  Created by apple on 2020/9/12.
//  Copyright © 2020 史圣久. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
//    override func viewDidLoad() {
//        view.addSubview(a)
//        a.backgroundColor = UIColor.white
//        a.setNeedsDisplay()
//    }
//
//    var a = DrawingView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
    
    private(set) lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    private var flipCount = 0 {
        didSet{
            updateflipCountLabel()
        }
    }
    
    private func updateflipCountLabel() {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        ]
        let attributedString = NSAttributedString(string: "Flips:\(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateflipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func reStart(_ sender: UIButton) {
        reSetGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCount += game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            NSLog("chosen card was not in cardButtons")
        }
    }
    
    // 更新每个卡片的信息
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            // cardButtons.indices 等价于 0..<cardButtons.count
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: game.cards[index]), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                button.isHidden = card.isMatch ? true : false
            }
        }
    }
    
    var theme: String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
//    private var emojiChoices = ["👻", "🎃", "😈", "☠️", "🦇", "🍎"]
    private var emojiChoices = "👻🎃😈☠️🦇🍎"
    
    private var emoji = [Card: String]()
    
    // 从词典中获取卡片对应的图片，如果没有对应的图片，则随机选一个图库里的加入
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil && emojiChoices.count > 0{
            // 随机数[0-UInt32(emojiChoices.count))
//            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            // 删除图库里的图片，并将返回值加入词典
        }
        return emoji[card] ?? "?"
    }
    
    func reSetGame() {
        self.game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
        //emojiChoices = ["👻", "🎃", "😈", "☠️", "🦇", "🍎"]
        emojiChoices = "👻🎃😈☠️🦇🍎"
        self.flipCount = 0
        Card.identifierFactory = 0
        game.randomCards()
        updateViewFromModel()
    }
}


extension Int {
    //拓展Int，返回0-self间的随机数
    var arc4random: Int {
        if self == 0 { return 0 }
        return Int(arc4random_uniform(UInt32(abs(self))))
    }
}
