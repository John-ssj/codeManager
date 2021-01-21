//
//  ProIphoneViewController.swift
//  LearnCoreAnimation
//
//  Created by apple on 2021/1/19.
//

import Foundation
import UIKit

class ProIphoneViewController: UIViewController {
    
    var closeButton = UIButton()
    var actionButton = UIButton()
    var layerView = UIView()
    var subLayers: [UIView] = []
    
    var angle = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        closeButton.frame = CGRect(x: 10, y: 50, width: 20, height: 20)
        closeButton.backgroundColor = UIColor.red
        closeButton.addTarget(self, action: #selector(tapToDismissSelf), for: .touchDown)
        view.addSubview(closeButton)
        
        actionButton.frame = CGRect(x: 300, y: 50, width: 120, height: 50)
        actionButton.setTitle("start", for: .normal)
        actionButton.backgroundColor = UIColor.green
        actionButton.addTarget(self, action: #selector(actionStart), for: .touchDown)
        view.addSubview(actionButton)
        
        self.layerView.frame = CGRect(x: 120, y: 200, width: 200, height: 200)
        layerView.backgroundColor = UIColor.white
        view.addSubview(layerView)
        
        createSieve()
    }
    
    @objc func actionStart() {
        AffineMoveLayer()
    }
    
    func AffineMoveLayer() {
        let trans = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 2) {
            self.layerView.layer.setAffineTransform(trans)
        }
    }
    
    func createSieve() {
        layerView.backgroundColor = UIColor.clear
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(trans3D))
        layerView.addGestureRecognizer(panGesture)
        
        for i in 1...6 {
            let layer = UILabel()
            layer.frame = layerView.bounds
            layer.backgroundColor = UIColor.white
            layer.text = "\(i)"
            layer.textAlignment = .center
            layer.font = UIFont.systemFont(ofSize: 30)
            subLayers.append(layer)
            self.layerView.addSubview(layer)
        }
        var trans0 = CATransform3DIdentity
        trans0 = CATransform3DTranslate(trans0, 0, 0, layerView.bounds.width / 2)
        subLayers[0].layer.transform = trans0
        
        var trans1 = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 1, 0)
        trans1 = CATransform3DTranslate(trans1, 0, 0, layerView.bounds.width / 2)
        subLayers[1].layer.transform = trans1
        
        var trans2 = CATransform3DMakeRotation(CGFloat.pi / 2, 1, 0, 0)
        trans2 = CATransform3DTranslate(trans2, 0, 0, layerView.bounds.width / 2)
        subLayers[2].layer.transform = trans2
        
        var trans3 = CATransform3DIdentity
        trans3 = CATransform3DTranslate(trans3, 0, 0, -layerView.bounds.width / 2)
        subLayers[3].layer.transform = trans3
        
        var trans4 = CATransform3DMakeRotation(CGFloat.pi / 2, 0, -1, 0)
        trans4 = CATransform3DTranslate(trans4, 0, 0, layerView.bounds.width / 2)
        subLayers[4].layer.transform = trans4
        
        var trans5 = CATransform3DMakeRotation(CGFloat.pi / 2, -1, 0, 0)
        trans5 = CATransform3DTranslate(trans5, 0, 0, layerView.bounds.width / 2)
        subLayers[5].layer.transform = trans5
    }
    
    @objc func trans3D(sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: layerView)
        let angleX = angle.x + (point.x/30)
        let angleY = angle.y - (point.y/30)
        
        if sender.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
        
        var trans = CATransform3DIdentity
        trans.m34 = -1.0 / 1000.0
        trans = CATransform3DRotate(trans, angleX, 0, 1, 0)
        trans = CATransform3DRotate(trans, angleY, 1, 0, 0)
        
        layerView.layer.sublayerTransform = trans
    }
    
    @objc func tapToDismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }

}
