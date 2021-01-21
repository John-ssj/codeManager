//
//  ViewController.swift
//  PlayingCard
//
//  Created by apple on 2020/10/2.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayCardDeck()
    
    private var cardStack: [PlayingCard] = []
    private var showCardNumber = 0
    
    @IBOutlet weak var playingCardView: PlayingCardView!{
        didSet{
            // UISwipeGestureRecognizer滑动
            let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipeLeftGesture.direction = .left
            playingCardView.addGestureRecognizer(swipeLeftGesture)
            let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(preCard))
            swipeRightGesture.direction = .right
            playingCardView.addGestureRecognizer(swipeRightGesture)
            // UIPinchGestureRecognizer放大缩小
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(adjustFaceCardScale(sender:)))
            playingCardView.addGestureRecognizer(pinchGesture)
        }
    }
    
    
    // UITapGestureRecognizer点击
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp.toggle()
        default:
            break
        }
    }
    
    @objc func preCard() {
        if cardStack.indices.contains(showCardNumber-1) {
            print("ok1")
            showCardNumber -= 1
            playingCardView.rank = cardStack[showCardNumber].rank.num
            playingCardView.suit = cardStack[showCardNumber].suit.rawValue
        }
    }
    
    @objc func nextCard() {
            if cardStack.indices.contains(showCardNumber+1) {
                print("ok2")
                showCardNumber += 1
                playingCardView.rank = cardStack[showCardNumber].rank.num
                playingCardView.suit = cardStack[showCardNumber].suit.rawValue
            } else if let card = deck.draw() {
                print("ok3")
                cardStack.append(card)
                showCardNumber += 1
                playingCardView.rank = card.rank.num
                playingCardView.suit = card.suit.rawValue
            }
    }
    
    @objc func adjustFaceCardScale(sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .changed,.ended:
            playingCardView.faceCardScale *= sender.scale
            sender.scale = 1.0
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let card = deck.draw() {
            playingCardView.rank = card.rank.num
            playingCardView.suit = card.suit.rawValue
            self.cardStack.append(card)
            self.showCardNumber = 0
        }
    }


}
