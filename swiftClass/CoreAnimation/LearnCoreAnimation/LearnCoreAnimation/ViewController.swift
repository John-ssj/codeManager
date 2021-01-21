//
//  ViewController.swift
//  LearnCoreAnimation
//
//  Created by apple on 2021/1/16.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    let layerView = UIView()
    let blueLayer = CALayer()
    let imageView = UIImageView()
    
    var timer: Timer!
    var clockView = UIImageView()
    var hourHand = UIImageView()
    var minuteHand = UIImageView()
    var secondHand = UIImageView()
    
    var digitViews: [UIView] = []
    
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // 进入下个页面
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(jumpToNextView))
        gesture.direction = .down
        self.view.addGestureRecognizer(gesture)
        
        view.addSubview(layerView)
        layerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            layerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            layerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            layerView.widthAnchor.constraint(equalToConstant: 200),
            layerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        layerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
//        setUpLayers()
        
//        drawInLayerWithCoreGraphics()
        
//        MakeAClock()
        
//        setUpCALayerBorder()
//        setUpShadow()
        
//        setUpMaskLayer()
        
//        setUpColorfulCircle()
        
//        setUpLCDclock()
        
//        subLayerInSameColor()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let point = touches.first!.location(in: self.view)
        
        // 利用layer.contains判断点的位置是否在图层内
//        containsPointTest(point)
        
        // 利用layer.contains判断点的在那个图层
//        hitTestPoint(point)
    }
    
    func setUpCALayerBorder() {
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.cornerRadius = 50
        blueLayer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        self.layerView.layer.addSublayer(blueLayer)
        
        layerView.layer.borderWidth = 5
        layerView.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
        layerView.layer.cornerRadius = 30
        //masksToBounds会使阴影不可见
        layerView.layer.masksToBounds = true
    }
    
    func setUpShadow() {
        blueLayer.shadowOpacity = 0.5
//        layerView.layer.shadowRadius = 5
//        layerView.layer.shadowOffset = CGSize(width: -10, height: 10)
        let circlePath = CGPath(ellipseIn: self.blueLayer.bounds.offsetBy(dx: 10, dy: 10), transform: nil)
        blueLayer.shadowPath = circlePath
    }
    
    func setUpMaskLayer() {
        let maskLayer = CALayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

        let maskImage = UIImage(named: "hand")
        maskLayer.contents = maskImage?.cgImage

        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        layerView.addSubview(imageView)
        imageView.image = UIImage(named: "clockAndPointer")
        imageView.layer.contentsRect = CGRect(x: 0.01, y: 0.01, width: 0.5, height: 0.98)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.mask = maskLayer
    }
    
    func setUpColorfulCircle() {
        let grandLayer = CAGradientLayer()
        grandLayer.colors = [UIColor.yellow, .red, .blue].map {$0.cgColor }
        grandLayer.startPoint = CGPoint(x: 0, y: 0)
        grandLayer.endPoint = CGPoint(x: 1, y: 1)
        grandLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.layerView.layer.addSublayer(grandLayer)
        
        let sharpLayer = CAShapeLayer()
        sharpLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        sharpLayer.lineWidth = 15
        sharpLayer.strokeColor = UIColor.white.cgColor
        sharpLayer.fillColor = nil
        sharpLayer.path = UIBezierPath(arcCenter: sharpLayer.position, radius: (sharpLayer.bounds.width  - 15) / 2 , startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        grandLayer.mask = sharpLayer
    }
    
    
    func containsPointTest(_ pointInView: CGPoint) {
        var point = self.layerView.layer.convert(pointInView, from: self.view.layer)
        //get layer using containsPoint:
        if self.layerView.layer.contains(point) {
            //convert point to blueLayer’s coordinates
            point = self.blueLayer.convert(point, from: self.layerView.layer)
            let alert = UIAlertController(title: "Notice", message: "Inside Blue Layer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if self.blueLayer.contains(point) {
                alert.message = "Inside Blue Layer"
                self.present(alert, animated: true, completion: nil)
            } else {
                alert.message = "Inside White Layer"
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func hitTestPoint(_ pointInView: CGPoint) {
        let layer = self.layerView.layer.hitTest(pointInView)
        
        let alert = UIAlertController(title: "Notice", message: "Inside Blue Layer", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        switch layer {
        case self.layerView.layer:
            alert.message = "Inside White Layer"
            self.present(alert, animated: true, completion: nil)
        case self.blueLayer:
            alert.message = "Inside Blue Layer"
            self.present(alert, animated: true, completion: nil)
        default:
            return
        }
    }
    
    func setUpLayers() {
        layerView.addSubview(imageView)
        imageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        //withTintColor设置颜色，并把withRenderingMode设成.alwaysOriginal。
        //或者直接设置UIImageView的tintColer.
        imageView.image = UIImage(systemName: "pencil.circle.fill")?.withTintColor(UIColor.orange).withRenderingMode(.alwaysOriginal)
        
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.contents = UIImage(systemName: "pencil.circle.fill")?.cgImage
        self.layerView.layer.addSublayer(blueLayer)
        
        //直接用layer.contents呈现cgImage图片
        let image = UIImage(systemName: "pencil.circle.fill")
        layerView.layer.contents = image?.cgImage
        
        //contentsGravity = .center时可以自己更改像素比例。
        //contentScaleFactor和.layer.contentsScale等效
        self.layerView.contentMode = .scaleAspectFit
        layerView.layer.contentsGravity = .center
        layerView.layer.contentsScale = image?.scale ?? 1.0
        layerView.contentScaleFactor = 2.0
        
        //clipsToBounds和.layer.masksToBounds等效
        layerView.layer.contentsGravity = .resizeAspectFill
        layerView.clipsToBounds = true
        layerView.layer.masksToBounds = true
            
        //.layer.contentsRect对背景图像进行剪裁，数值为整张图片的百分比。
        //如CGRect(x: 0, y: 0, width: 0.5, height: 0.5)显示图片左上角的1/4。
        layerView.layer.contentsGravity = .resizeAspect
        layerView.layer.contentsRect = CGRect(x: 0, y: 0, width: 0.5, height: 1)
        
        //contentsCenter按照百分比设置一个rect，对其中间部分进行缩放，四个角的大小永远不变。
        layerView.layer.contentsCenter = CGRect(x: 0.5, y: 0, width: 0.5, height: 1)
    }
    
    //用layar画图
    func drawInLayerWithCoreGraphics() {
        blueLayer.delegate = self
        blueLayer.contentsScale = UIScreen.main.scale
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        layerView.layer.addSublayer(blueLayer)

        //force layer to redraw 让layer强制重画
        blueLayer.display()
    }
    
    func subLayerInSameColor() {
        layerView.backgroundColor = UIColor.clear
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        button.backgroundColor = UIColor.white
        layerView.addSubview(button)
        
        let label = UILabel()
        label.text = "HELLO"
        label.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        button.addSubview(label)
        
        //shouldRasterize没发现有啥用?
        button.layer.shouldRasterize = true
        button.alpha = 0.5
    }
    
    func MakeAClock() {
        let clockImage = UIImage(named: "clockAndPointer")
        
        clockView.image = clockImage
        clockView.layer.contentsRect = CGRect(x: 0.01, y: 0.01, width: 0.5, height: 0.98)
        clockView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        layerView.addSubview(clockView)
        
        let handsImage = UIImage(named: "hand")
        hourHand.image = handsImage
        hourHand.layer.contentsRect = CGRect(x: 0.0, y: 0.0, width: 0.27, height: 1.0)
        hourHand.center = CGPoint(x: 100, y: 100)
        hourHand.bounds = CGRect(x: 0, y: 0, width: 18, height: 70)
        hourHand.layer.anchorPoint = CGPoint(x: 0.5, y: 0.87)
        clockView.addSubview(hourHand)
        
        minuteHand.image = handsImage
        minuteHand.layer.contentsRect = CGRect(x: 0.36, y: 0.0, width: 0.27, height: 1.0)
        minuteHand.center = CGPoint(x: 100, y: 100)
        minuteHand.bounds = CGRect(x: 0, y: 0, width: 21, height: 80)
        minuteHand.layer.anchorPoint = CGPoint(x: 0.5, y: 0.87)
        clockView.addSubview(minuteHand)

        secondHand.image = handsImage
        secondHand.layer.contentsRect = CGRect(x: 0.8, y: 0.0, width: 0.2, height: 1.0)
        secondHand.center = CGPoint(x: 100, y: 100)
        secondHand.bounds = CGRect(x: 0, y: 0, width: 20, height: 90)
        secondHand.layer.anchorPoint = CGPoint(x: 0.5, y: 0.78)
        clockView.addSubview(secondHand)
        
        // 建立timer，设置刷新时间，处理函数，是否循环
        self.timer = Timer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        // 将timer添加到RunLoop中
        RunLoop.current.add(self.timer, forMode: .default)
        
        // fire开始使用timer
        timer.fire()
        
    }
    
    
    @objc func tick() {
        // 建立日历
        let calendar = Calendar(identifier: .gregorian)
        // units为需要获取的时间内容。
        let uints: Set = [Calendar.Component.hour, .minute, .second]
        // 从Date()中获取时间，放到calendar中，并用units设置需要的时间参数
        let components = calendar.dateComponents(uints, from: Date())
        let hoursAngle = (CGFloat(components.hour!) / 12.0) * CGFloat.pi * 2.0
        //calculate hour hand angle //calculate minute hand angle
        let minsAngle = (CGFloat(components.minute!) / 60.0) * CGFloat.pi * 2.0
        //calculate second hand angle
        let secsAngle = (CGFloat(components.second!) / 60.0) * CGFloat.pi * 2.0
        //rotate hands
        self.hourHand.transform = CGAffineTransform(rotationAngle: hoursAngle)
        self.minuteHand.transform = CGAffineTransform(rotationAngle: minsAngle)
        self.secondHand.transform = CGAffineTransform(rotationAngle: secsAngle)
    }
    
    func setUpLCDclock() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.isLandscape = true
            _ = appDelegate.application(UIApplication.shared, supportedInterfaceOrientationsFor: view.window)
            
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
        
        for cons in layerView.constraints {
            if cons.firstAttribute == NSLayoutConstraint.Attribute.width {
                cons.constant = 490
            }
        }
        
        guard let digits = UIImage(named: "Digits") else {
            return
        }
        
        for i in 0..<6 {
            let view = UIView()
            self.digitViews.append(view)
            view.layer.contents = digits.cgImage
            view.layer.contentsRect = CGRect(x: 0, y: 0, width: 0.1, height: 1.0)
            view.frame = CGRect(x: (CGFloat(i) + (i<2 ? 0.0: (i<4 ? 0.5:1.0))) * 70, y: 0, width: 70, height: 200)
            view.layer.magnificationFilter = .linear
            view.layer.contentsGravity = .resizeAspect
            self.layerView.addSubview(view)
        }
        
        self.timer = Timer(timeInterval: 1, target: self, selector: #selector(newTick), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer, forMode: .default)
        timer.fire()
        
    }
    
    func setDigit(digit: Int,forView view: UIView) {
        view.layer.contentsRect = CGRect(x: CGFloat(digit) * 0.1, y: 0, width: 0.1, height: 1.0)
    }
    
    @objc func newTick() {
        let calender = Calendar(identifier: .gregorian)
        let uints: Set = [Calendar.Component.hour, .minute, .second]
        let components = calender.dateComponents(uints, from: Date())
        
        setDigit(digit: components.hour! / 10, forView: self.digitViews[0])
        setDigit(digit: components.hour! % 10, forView: self.digitViews[1])
        
        setDigit(digit: components.minute! / 10, forView: self.digitViews[2])
        setDigit(digit: components.minute! % 10, forView: self.digitViews[3])
        
        setDigit(digit: components.second! / 10, forView: self.digitViews[4])
        setDigit(digit: components.second! % 10, forView: self.digitViews[5])
    }

    @objc func jumpToNextView() {
        let vc = ProIphoneViewController()
        vc.modalPresentationStyle = .fullScreen
//        vc.view.alpha = 0.5
        transitionManager.transStatus = .rotate
        vc.transitioningDelegate = transitionManager
        self.present(vc, animated: true, completion: nil)
    }
}


//CALayerDelegate不会处理超出frame的部分，会自动将超出部分剪裁掉
extension ViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.setLineWidth(10)
        ctx.setStrokeColor(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))
        ctx.strokeEllipse(in: layer.bounds.insetBy(dx: 5, dy: 5))
    }
}
