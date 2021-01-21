//
//  TransitionManager.swift
//  LearnCoreAnimation
//
//  Created by apple on 2021/1/19.
//

import Foundation
import UIKit

class TransitionManager: NSObject{
    
    var status = true // ture 打开页面， false 关闭页面
    var transStatus: transitionModel = .horizontal
    
}

extension TransitionManager: UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.status = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.status = false
        return self
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //获得即将消失的view
        switch transStatus {
        case .horizontal:
            horizontalMoveFormRight(transitionContext: transitionContext)
        case .rotate:
            rotateFormRight(transitionContext: transitionContext)
        default:
            horizontalMoveFormRight(transitionContext: transitionContext)
        }
    }
    
    func horizontalMoveFormRight(transitionContext: UIViewControllerContextTransitioning) {
        //获得即将消失的view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey:UITransitionContextViewKey.to)!
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        toView.frame = containerView.frame
        
        if self.status {
            fromView.frame = CGRect(x: -containerView.frame.width, y: 0, width:containerView.frame.width, height: containerView.frame.height)
            fromView.layer.setAffineTransform(CGAffineTransform(translationX: containerView.frame.width, y: 0))
            toView.layer.setAffineTransform(CGAffineTransform(translationX: containerView.frame.width, y: 0))
        } else {
            fromView.frame = CGRect(x: containerView.frame.width, y: 0, width:containerView.frame.width, height: containerView.frame.height)
            fromView.layer.setAffineTransform(CGAffineTransform(translationX: -containerView.frame.width, y: 0))
            toView.layer.setAffineTransform(CGAffineTransform(translationX: -containerView.frame.width, y: 0))
        }
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration) {
            fromView.layer.setAffineTransform(CGAffineTransform(rotationAngle: 0))
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: 0))
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    func rotateFormRight(transitionContext: UIViewControllerContextTransitioning) {
        //获得即将消失的view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey:UITransitionContextViewKey.to)!
        let containerView = transitionContext.containerView
        containerView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        fromView.bounds = containerView.bounds
        fromView.layer.position = CGPoint(x: 0, y: 0)
        fromView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        toView.bounds = containerView.bounds
        toView.layer.position = CGPoint(x: 0, y: 0)
        toView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        
        if self.status {
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: -CGFloat.pi / 2))
        } else {
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi / 2))
        }
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration - 0.2) {
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: 0))
        }
        
        UIView.animate(withDuration: duration - 0.2, delay: 0.2) {
            if self.status {
                fromView.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi / 2))
            } else {
                fromView.layer.setAffineTransform(CGAffineTransform(rotationAngle: -CGFloat.pi / 2))
            }
        } completion: { _ in
            transitionContext.completeTransition(true)
        }

        
    }
}

extension TransitionManager {
    enum transitionModel {
        case horizontal
        case rotate
        case scale
        case Trans3D
    }
}
