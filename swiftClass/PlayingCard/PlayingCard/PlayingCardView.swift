//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by apple on 2020/12/3.
//

import UIKit


// MARK: - @IBDesignable:在storyboard中展示
/*
 IBDesignable后面的class能够在storyboard中展示
 默认无法展示图片，需要在UIImage后面加上in: Bundle(for: self.classForCoder)和compatibleWith: traitCollection
 如：UIImage(named: "...", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection)
 */

@IBDesignable
class PlayingCardView: UIView {
    
    // IBInspectable后面的那个属性会在右边的inspecter中显示（注意:需要写明每个变量的具体类型）
    @IBInspectable
    var rank: Int = 5 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var suit: String = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var isFaceUp: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var faceCardScale: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize { didSet { setNeedsDisplay()} }
    
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()
    
    private var cornerString: NSAttributedString {
        return centeredAttributedString(string: rankString+"\n"+suit, size: cornerFontSize)
    }
    
    
    private func centeredAttributedString(string: String, size: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(size)
        // 设置可以随系统设置自动改变大小的字体
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, NSAttributedString.Key.font : font])
    }
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = cornerString
        // 自动调节label大小
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }
    
    private func drawPips()
    {
        let pipsPerRowForRank = [[0],[1],[1,1],[1,1,1],[2,2],[2,1,2],[2,2,2],[2,1,2,2],[2,2,2,2],[2,2,1,2,2],[2,2,2,2,2]]
        
        func createPipString(thatFits pipRect: CGRect) -> NSAttributedString {
            // MARK: - reduce函数
            /*
             reduce函数，有两个参数第一个是累加器$0,第二个参数是数组的每一个元素。
             {}内的语句执行完后，结果会赋值给累加器$0。最后返回的值也是累加器$0。
             */
            let maxVerticalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($0, $1.count) })
            let maxHorizontalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($0,$1.max() ?? 0) })
            let verticalPipRowSpacing = pipRect.size.height / maxVerticalPipCount
            let attemptedPipString = centeredAttributedString(string: suit, size: verticalPipRowSpacing)
            let probablyOkayPipStringFontSize = verticalPipRowSpacing / (attemptedPipString.size().height / verticalPipRowSpacing)
            let probablyOkayPipString = centeredAttributedString(string: suit, size: probablyOkayPipStringFontSize)
            if probablyOkayPipString.size().width > pipRect.size.width / maxHorizontalPipCount {
                return centeredAttributedString(string: suit, size: probablyOkayPipStringFontSize / (probablyOkayPipString.size().width / (pipRect.size.width / maxHorizontalPipCount)))
            } else {
                return probablyOkayPipString
            }
        }
        
        if pipsPerRowForRank.indices.contains(rank) {
            let pipsPerRow = pipsPerRowForRank[rank]
            var pipRect = bounds.insetBy(dx: cornerOffset, dy: cornerOffset).insetBy(dx: cornerString.size().width, dy: cornerString.size().height / 2)
            let pipString = createPipString(thatFits: pipRect)
            let pipRowSpacing = pipRect.size.height / CGFloat(pipsPerRow.count)
            pipRect.size.height = pipString.size().height
            pipRect.origin.y += (pipRowSpacing - pipRect.size.height) / 2
            for pipCount in pipsPerRow {
                switch pipCount {
                case 1:
                    pipString.draw(in: pipRect)
                case 2:
                    pipString.draw(in: pipRect.leftHalf)
                    pipString.draw(in: pipRect.rightHalf)
                default:
                    break
                }
                pipRect.origin.y += pipRowSpacing
            }
        }
    }
    
    //系统设置改变（如系统字体大小改变）
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    
    override func layoutSubviews() {
        // setNeedsLayout()将自动调用此方法
        
        super.layoutSubviews()
        
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = self.bounds.origin.offset(dx: cornerOffset, dy: cornerOffset)
        
        configureCornerLabel(lowerRightCornerLabel)
        // MARK:- transform图形变换：
        // translatedBy移动，rotated旋转（以左上角为原点），伸缩变换...
        lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.bounds.width, y: lowerRightCornerLabel.bounds.height)
            .rotated(by: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
            .offset(dx: -lowerRightCornerLabel.bounds.width, dy: -lowerRightCornerLabel.bounds.height)
            .offset(dx: -cornerOffset, dy: -cornerOffset)
    }
    
    
    override func draw(_ rect: CGRect) {
        // setNeedsDisplay() 将自动调用此方法

        UIGraphicsGetCurrentContext()
        
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundRect.addClip()
        UIColor.white.setFill()
        roundRect.fill()
        
        if isFaceUp {
            if let faceCardImage = UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection){
                faceCardImage.draw(in: self.bounds.zoom(by: faceCardScale))
            }else {
                drawPips()
            }
        } else if let backImage = UIImage(named: "cardback", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection){
            backImage.draw(in: self.bounds)
        }
    }
    
    
    
}


extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight:CGFloat = 0.085
        static let cornerRadiusToBoundsHeight:CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var rankString:String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
    
}


extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: minX+width/2, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width-newWidth)/2, dy: (height-newHeight)/2)
    }
    
}


extension CGPoint {
    func offset(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
