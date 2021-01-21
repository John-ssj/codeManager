//
//  DrawingView.swift
//  cs193p
//
//  Created by apple on 2020/12/2.
//  Copyright © 2020 史圣久. All rights reserved.
//

import Foundation
import UIKit

class DrawingView: UIView {
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        drawrect(context: context)
    }
    
    func drawrect(context: CGContext?){
        
        #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).setStroke()
        #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.3).setFill()
        
        
        let image = UIImage(named: "bacgroundImg")
        image?.draw(in: CGRect(x: -50, y: 0, width: 300, height: 200))
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 60))
        path.addArc(withCenter: CGPoint(x: 100, y: 60), radius: 50, startAngle: 0, endAngle: -3.14/2, clockwise: false)
        path.close()
        
        // 保存原来的context
        context?.saveGState()
        //剪裁context，之后的画布大小为path里的范围
        path.addClip()
        
        let pathb = UIBezierPath()
        pathb.move(to: CGPoint(x: 0, y: 0))
        pathb.addLine(to: CGPoint(x: 200, y: 0))
        pathb.addLine(to: CGPoint(x: 200, y: 200))
        pathb.addLine(to: CGPoint(x: 0, y: 200))
        pathb.close()
        
        pathb.lineWidth = 3.0
        pathb.fill()
        pathb.stroke()
        
        //恢复context
        context?.restoreGState()
        
        //用NSAttributedString画字
        let text = NSAttributedString(string: "hello", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .body)])
        text.draw(at: CGPoint(x: 0, y: 10))
        
        
        //利用NSRange对一句话中的不同文字使用不同效果
        let words2 = "hi john!"
        
        //设置大小可以自动调节的字体（当它为.body时，size为36。当系统字体变大时会自动相应变大）
        let metrics = UIFontMetrics(forTextStyle: .body)
        let fontToUse = metrics.scaledFont(for: UIFont.systemFont(ofSize: 30))
        
        let text2 = NSMutableAttributedString(string: words2, attributes: [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : fontToUse])
        let firstWordRange = words2.startIndex..<words2.firstIndex(of: " ")!
        let nsrange = NSRange(firstWordRange, in: words2)
        text2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: nsrange)
        text2.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.brown, range: nsrange)
        text2.draw(at: CGPoint(x: 0, y: 35))
        
    }
}
